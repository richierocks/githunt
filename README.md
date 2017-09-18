githunt: An R package to get the email address from a github username
=====================================================================

Trawl a github user's public events data for their email address.

Installation
------------

First, install the devtools package

    install.packages("devtools")

Then install this

    devtools::install_github("richierocks/githunt")

Usage
-----

The only function is `get_email_addresses()`, which takes a github
username as its only argument.

    library(githunt)
    get_email_addresses("richierocks")

    ## [1] "richierocks@gmail.com"

Isn't this creepy?
------------------

Yes, a little. Please use the package responsibly.

github stores a lot of data about your activities on public
repositories. See

    https://api.github.com/users/your-github-username/events/public

for what is being stored about yourself.

If you are concerned about your email address being made public,  you can learn how to keep your email address private in the [GitHub documentation](https://help.github.com/articles/about-commit-email-addresses/).
