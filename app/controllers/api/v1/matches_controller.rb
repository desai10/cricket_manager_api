class Api::V1::MatchesController < ApplicationController

    before_action :find_match, only: [:show, :update, :destroy, :toss, :start_innings]

    def start_innings
        if @match
            if @match.toss
                strike_b = User.find(params[:strike_batsman_id])
                non_strike_b = User.find(params[:non_strike_batsman_id])
                b = User.find(params[:bowler_id])
                unless strike_b && non_strike_b && b
                    render error: {error: 'Player not found'}, status: 400
                else
                    if @match.first_innings.status.casecmp('NOT STARTED')
                        if !@match.first_innings.team.users.include?(strike_b) || !@match.first_innings.team.users.include?(non_strike_b)
                            render error: {error: 'Batsman does not belong to batting team'}, status: 400
                        elsif !@match.second_innings.team.users.include? b
                            render error: {error: 'Bowler does not belong to bowling team'}, status: 400
                        else
                            @match.first_innings.strike_batsman = strike_b
                            @match.first_innings.non_strike_batsman = non_strike_b
                            @match.first_innings.bowler = b
                            @match.first_innings.status = 'STARTED'
                        end
                        if @match.save
                            render json: @match, include: [:home_team, :away_team, :first_innings, :second_innings]
                        else
                            render error: {error: 'Unable to save changes'}, status: 400
                        end
                    elsif @match.first_innings.status.casecmp('FINISHED') && @match.second_innings.start.casecmp('NOT STARTED')
                        if !@match.first_innings.team.users.include?(strike_b) || !@match.first_innings.team.users.include?(non_strike_b)
                            render error: {error: 'Batsman does not belong to batting team'}, status: 400
                        elsif !@match.first_innings.team.users.include? b
                            render error: {error: 'Bowler does not belong to bowling team'}, status: 400
                        else
                            @match.second_innings.strike_batsman = strike_b
                            @match.second_innings.non_strike_batsman = non_strike_b
                            @match.second_innings.bowler = b
                            @match.second_innings.status = 'STARTED'
                        end
                        if @match.save
                            render json: @match, include: [:home_team, :away_team, :first_innings, :second_innings]
                        else
                            render error: {error: 'Unable to save changes'}, status: 400
                        end
                    else
                        render error: {error: "Can't start innings when an innings has already started!"}, status: 400
                    end
                end
            else
                render error: {error: "Can't start innings unless toss is done!"}, status: 400
            end
        else
            render error: {error: "Can't find match"}, status: 404
        end
    end

    def toss
        if @match
            unless @match.toss
                if !['HOME', 'AWAY'].include? params[:won_by].upcase
                    render error: {error: 'won_by must be either HOME or AWAY'}, status: 400
                elsif !['BAT', 'BOWL'].include? params[:decision].upcase
                    render error: {error: 'decision must be either BAT or BOWL'}, status: 400
                else
                    @match.toss = params[:won_by].upcase
                    @match.toss_decision = params[:decision].upcase
                    i1 = Inning.create(team: @match.home_team, strike_batsman: @match.home_team.users.first, non_strike_batsman: @match.home_team.users.second, bowler: @match.away_team.users.first)
                    i2 = Inning.create(team: @match.away_team, strike_batsman: @match.away_team.users.first, non_strike_batsman: @match.away_team.users.second, bowler: @match.home_team.users.first)
                    if @match.toss == "HOME"
                        if @match.toss_decision == 'BAT'
                            @match.first_innings = i1
                            @match.second_innings = i2
                        else
                            @match.first_innings = i2
                            @match.second_innings = i1
                        end
                    else
                        if @match.toss_decision == 'BAT'
                            @match.first_innings = i2
                            @match.second_innings = i1
                        else
                            @match.first_innings = i1
                            @match.second_innings = i2
                        end
                    end
                    if @match.save
                        render json: @match, include: [:home_team, :away_team, :first_innings, :second_innings]
                    else
                        render error: {error: 'Unable to save changes'}, status: 400
                    end
                end
            else
                render error: {error: "Toss is already done for this match!"}, status: 400
            end
        else
            render error: {error: "Can't find match"}, status: 404
        end
    end

    def index
        @matches = Match.all
        render json: @matches, include: [:home_team, :away_team, :first_innings, :second_innings]
    end

    def show
        render json: @match, include: [:home_team, :away_team, :first_innings, :second_innings]
    end

    def create
        t1 = Team.find(params[:match][:home_team])
        t2 = Team.find(params[:match][:away_team])
        i1 = Inning.create(team:t1, strike_batsman: t1.users.first, non_strike_batsman: t1.users.second, bowler: t2.users.first)
        i2 = Inning.create(team:t2, strike_batsman: t2.users.first, non_strike_batsman: t2.users.second, bowler: t1.users.first)
        @match = Match.new(home_team: t1, away_team: t2, first_innings: i1, second_innings: i2)
        if @match.save
            @match.home_team.users.each do |u|
                Stat.create(user: u, match: @match)
            end
            @match.away_team.users.each do |u|
                Stat.create(user: u, match: @match)
            end
            render json: @match, include: [:home_team, :away_team, :first_innings, :second_innings]
        else
            render error: {error: 'Unable to create match'}, status: 400
        end
    end

    def update
        if @match
            @match.update(match_params)
        else
            render error: {error: "Can't find match."}, status: 404
        end
    end

    def destroy
        if @match
            @match.destroy
        else
            render error: {error: "Can't find match."}, status: 404
        end
    end

    private
    
    def match_params
        params.require(:match).permit(:home_team, :away_team)
    end

    def find_match
        @match = Match.find(params[:id])
    end
end
