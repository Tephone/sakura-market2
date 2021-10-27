class Sellers::ApplicationController < ApplicationController
  before_action :authenticate_seller!
end
