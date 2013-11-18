class UsersController < ApplicationController
  before_action :user_signed_in?, only: [:index,:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]



end

