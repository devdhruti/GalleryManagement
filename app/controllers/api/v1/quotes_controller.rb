class Api::V1::QuotesController < Api::V1::AuthenticatedController

  # GET /api/v1/quotes
  def index
    authorize_user!

    begin
      @quotes = current_user.quotes.order('created_at')
    rescue => e
      render_exception(e, 422) && return
    end
    render json: QuoteSerializer.new(@quotes).serializable_hash
  end

  # POST /api/v1/quotes
  def create
    authorize_user!

    begin
      quote = Quote.create!(quotes_params.merge(user_id: current_user.id))
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(QuoteSerializer.new(quote).serializable_hash[:data][:attributes])
  end

  # DELETE /api/v1/quotes/id
  def destroy
    authorize_user!

    begin
      @quote = Quote.find(params[:id])
      validate!(@quote.user_id)
      
      @quote.destroy

    rescue => e
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  # PUT /api/v1/quotes/id
  def update
    authorize_user!

    begin
      @quote = Quote.find(params[:id])
      validate!(@quote.user_id)
      @quote.update!(quotes_params.merge(user_id: current_user.id))
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(QuoteSerializer.new(@quote).serializable_hash[:data][:attributes])
  end

  private
  def quotes_params
    params.require(:quote).permit(:quotes)
  end
end
