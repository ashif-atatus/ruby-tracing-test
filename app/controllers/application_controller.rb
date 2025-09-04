class ApplicationController < ActionController::API
  def index
    render json: {
      message: "Hello Ruby Tracing Test!"
    }
  end

  def health
        render json: { status: :ok }
  end
end
