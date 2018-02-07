class TaxpayersChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "taxpayers"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
