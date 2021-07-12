class Api::V1::UsersController < ApplicationController

    before_action :find_user, only: [:show, :update, :destroy, :leave_team]

    def leave_team
        if @user
            @team = @user.teams.find(params[:team_id])
            if @team
                @user.teams.delete(@team)
                if @user.save
                    render json: @user.teams
                else
                    render error: {error: "Unable to update user."}, status: 400
                end
            else
                render error: {error: "Can't find this team for this user."}, status: 400
            end
        else
            render error: {error: "Can't find user."}, status: 404
        end
    end

    def index
        @users = User.all
        render json: @users
    end

    def show
        render json: @user
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user
        else
            render error: {error: 'Unable to create user'}, status: 400
        end
    end

    def update
        if @user
            @user.update(user_params)
        else
            render error: {error: "Can't find user."}, status: 404
        end
    end

    def destroy
        if @user
            @user.destroy
        else
            render error: {error: "Can't find user."}, status: 404
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :password, :name)
    end

    def find_user
        @user = User.find(params[:id])
    end
    
end
