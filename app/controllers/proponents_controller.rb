class ProponentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_proponent, only: [ :show, :edit, :update, :destroy ]

  def index
    @proponents = Proponent.page_kaminari(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def new
    @proponent = Proponent.new
  end

  def create
    @proponent = Proponent.new(proponent_params)

    if @proponent.save
      flash[:notice] = "Proponente foi criado com sucesso"
      redirect_to @proponent
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @proponent.update(proponent_params)
      flash[:notice] = "Proponente foi atualizado com sucesso"
      redirect_to @proponent
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @proponent.destroy

    redirect_to proponents_path
  end

  def calculate_inss_discount
    gross_salary = params[:salary].to_f
    service = InssCalculationService.new(gross_salary)
    result = service.call

    render json: { discount: result[:discount] }
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  def proponent_params
    params.require(:proponent).permit(:name, :cpf, :birth_date, :street, :number, :neighborhood, :city, :state, :zip_code, :personal_phone, :reference_phone, :salary)
  end
end
