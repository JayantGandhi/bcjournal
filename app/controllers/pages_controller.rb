class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def submit
  end

  def splash
    @no_nav = true
  end

  def call_for_submissions
    render layout: false
  end

  def privacy_policy
  end
end
