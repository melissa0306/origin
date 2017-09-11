class BalancesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_balance, only: [:show, :edit, :update, :destroy]
   
    def index
        @balances = Balance.all
    end
    
    def show
        
    end
    
    def new
        @balance = current_user.balances.build
    end
    
    def edit
    end
    
    def create
       
       @balance = current_user.balances.build(balance_params)
        
        respond_to do |format|
            if @balance.save
                format.html {redirect_to @balance, notice: 'Daten wurden erzeugt'}
                format.json {render :show, status: :ok, location: @balance }
            else
                format.html { render :new}
                format.json { render json: @balance.errors, status: :unprocessable_entitiy }
            end
        end
    end
   
     def update
        respond_to do |format|
            if @balance.save
                format.html {redirect_to @balance, notice: 'Daten wurden eingetragen'}
                format.json {render :show, status: :ok, location: @balance }
            else
                format.html { render :edit}
                format.json { render json: @balance.errors, status: :unprocessable_entitiy }
            end
        end
    end
    
    def destroy
        respond_to do |format|
            format.html {redirect_to balance_url, notice: 'Daten wurden gelöscht'}
            format.json {head :no_content }
        end
    end
    
    
     private
    def set_balance
        @balance = Balance.find(params[:id])
    end
  
    
    def balance_params
        params.require(:balance).permit(:date, :emission, :track_length, :user_id)
    end
end
