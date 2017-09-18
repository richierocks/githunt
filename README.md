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

    get_email_addresses("richierocks")
