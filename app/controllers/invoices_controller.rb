class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @calculs = Calculs.new(@invoice.rent)

    #@tax = @calculs.tax
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to @invoice
    else
      render 'new'
    end
  end

  private
    def invoice_params
      params.require(:invoice).permit(:rent)
    end
end
