# This handles the logic for serving static files, mainly Snap!
class PagesController < ApplicationController
  include HighVoltage::StaticPage
  
  
end
