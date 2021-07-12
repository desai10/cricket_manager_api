class Api::V1::TournamentsController < ApplicationController

    before_action :find_tournament, only: [:show, :update, :destroy, :add_team, :add_teams]

    def add_team
        if @tournament
            @team = Team.find(params[:team_id])
            if @team
                @tournament.teams << @team
                if @tournament.save
                    render json: @tournament.teams
                else
                    render error: {error: 'Unable to update tournament'}, status: 400
                end
            else
                render error: {error: "Can't find team."}, status: 404
            end
        else
            render error: {error: "Can't find tournament."}, status: 404
        end
    end

    def add_teams
        if @tournament
            unless params[:team_ids].empty?
                params[:team_ids].each do |team_id|
                    team = Team.find(team_id)
                    if team
                        @tournament.teams << team
                    end
                end
            end
            if @tournament.save
                render json: @tournament.teams
            else
                render error: {error: 'Unable to update tournament'}, status: 400
            end
        else
            render error: {error: "Can't find tournament."}, status: 404
        end
    end

    def index
        @tournaments = tournament.all
        render json: @tournaments
    end

    def show
        render json: @tournament
    end

    def create
        @tournament = tournament.new(tournament_params)
        if @tournament.save
            render json: @tournament
        else
            render error: {error: 'Unable to create tournament'}, status: 400
        end
    end

    def update
        if @tournament
            @tournament.update(tournament_params)
        else
            render error: {error: "Can't find tournament."}, status: 404
        end
    end

    def destroy
        if @tournament
            @tournament.destroy
        else
            render error: {error: "Can't find tournament."}, status: 404
        end
    end

    private
    
    def tournament_params
        params.require(:tournament).permit(:name)
    end

    def find_tournament
        @tournament = tournament.find(params[:id])
    end
end
