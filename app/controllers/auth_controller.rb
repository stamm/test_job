class AuthController < ApplicationController
  before_filter :authenticate_user!
end