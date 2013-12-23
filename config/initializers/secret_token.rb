# -*- encoding : utf-8 -*-
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
#
# Application.config.secret_key_base was added after upgrade to Rails4.0
# Read PR https://github.com/rails/rails/pull/9978 for more details

Blog::Application.config.secret_token = APP_CONFIG[:secret_token]
Blog::Application.config.secret_key_base = APP_CONFIG[:secret_key_base]
