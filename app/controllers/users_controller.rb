class UsersController < ApplicationController


    def edit
        @user = User.find params[:id]
    end

    def update
        @user = User.find params[:id]
        if @user.update_attributes( allowed_params )
            redirect_to @user, :notice => "Cadastro atualizado com sucesso!"
        else
            render :edit
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new allowed_params 
        if @user.save
            SingupMailer.confirm_email(@user).deliver
            redirect_to @user, :notice => "Cadastro realizado com sucesso!"
        else
            render :new
        end

    end

    def show
        @user = User.find params[:id]
    end

    private 
        def allowed_params
            params.require(:user).permit(:full_name,:email, :location ,:password,:password_confirmation, :bio)
        end

end