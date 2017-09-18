#' Get email address from github username
#'
#' Gets the email address of a person based upon their github username.
#' @param github_username A string containing someone's github username.
#' @return A character vector (probably of length 1) containing the email
#' address of that user.
#' @details This currently trawls the whole of the user's github public event
#' data for strings that look like email addresses. that means that other
#' email addresses beyond the one belonging to the github user could be found
#' (though this seems to be a rare thing).
#' @examples
#' get_email_addresses("richierocks")
#' @importFrom assertive.types assert_is_a_string
#' @importFrom httr GET
#' @importFrom httr stop_for_status
#' @importFrom httr content
#' @importFrom magrittr %>%
#' @importFrom stats na.omit
#' @importFrom stringi stri_detect_fixed
#' @importFrom stringi stri_extract_all_regex
#' @export
get_email_addresses <- function(github_username) {
  assert_is_a_string(github_username)

  # Retrieve public events JSON data
  events_url <- sprintf(
    "https://api.github.com/users/%s/events/public",
    github_username
  )

  response <- GET(events_url)
  stop_for_status(response)
  contents <- content(response, as = "parsed")

  # Quick pass through JSON, getting fields containing @ character
  possible_email_elements <- contents %>%
    rapply(
      function(x) {
        if(stri_detect_fixed(x, "@")) {
          x
        } else {
          NULL
        }
      },
      how = "unlist"
    ) %>%
    unname()

  # Refine to match on emails
  email_rx <- "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$"
  possible_email_elements %>%
    stri_extract_all_regex(email_rx) %>%
    unlist(use.names = FALSE) %>%
    na.omit() %>%
    unique()
}
