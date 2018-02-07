class BusinessesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "businesses"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
