class LineItemsController < AuthController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]


  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    product = Product.find params[:product_id]
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart}
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @cart = @line_item.cart
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @cart }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:cart_id, :product_id)
    end
end
