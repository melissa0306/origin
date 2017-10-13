class BalancesController < ApplicationController
    before_action :set_balance, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :destroy, :index]
   
    def status
         @balances = Balance.all
        
        respond_to do |format|
            format.html
        end
    end
   
    def profil
        @balances = Balance.all
        
        respond_to do |format|
            format.html
        end
    end
    
    def analysis
        @balances = Balance.all
        
        respond_to do |format|
            format.html
        end
    end
   
    def index
        @balances = Balance.all
        
        respond_to do |format|
            format.html
        end
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
        @balance.destroy
        redirect_to status_balances_path
    end
    
    
    private
    def set_balance
        @balance = Balance.find(params[:id])
    end
  
    
    def balance_params
        params.require(:balance).permit(:date, :emission, :track_length, :user_id, :means_of_transport)
    end
    
    
end
