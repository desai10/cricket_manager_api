class Api::V1::TeamsController < ApplicationController
    before_action :find_team, only: [:show, :update, :destroy, :add_user, :add_users, :remove_user]

    def add_user
        if @team
            @user = User.find(params[:user_id])
            if @user
                @team.users << @user
                if @team.save
                    render json: @team.users
                else
                    render error: {error: 'Unable to update team'}, status: 400
                end
            else
                render error: {error: "Can't find user."}, status: 404
            end
        else
            render error: {error: "Can't find team."}, status: 404
        end
    end

    def add_users
        if @team
            unless params[:user_ids].empty?
                params[:user_ids].each do |user_id|
                    user = User.find(user_id)
                    if user
                        @team.users << user
                    end
                end
            end
            if @team.save
                render json: @team.users
            else
                render error: {error: 'Unable to update team'}, status: 400
            end
        else
            render error: {error: "Can't find team."}, status: 404
        end
    end

    def remove_user
        if @team
            @user = @team.users.find(params[:user_id])
            if @user
                @team.users.delete(@user)
                if @team.save
                    render json: @team.users
                else
                    render error: {error: 'Unable to update team'}, status: 400
                end
            else
                render error: {error: "Can't find user in this team."}, status: 400
            end
        else
            render error: {error: "Can't find team."}, status: 404
        end
    end

    def index
        @teams = Team.all
        render json: @teams
    end

    def show
        render json: @team
    end

    def create
        @team = Team.new(team_params)
        if @team.save
            render json: @team
        else
            render error: {error: 'Unable to create team'}, status: 400
        end
    end

    def update
        if @team
            @team.update(team_params)
        else
            render error: {error: "Can't find team."}, status: 404
        end
    end

    def destroy
        if @team
            @team.destroy
        else
            render error: {error: "Can't find team."}, status: 404
        end
    end

    private
    
    def team_params
        params.require(:team).permit(:name)
    end

    def find_team
        @team = Team.find(params[:id])
    end
end
