# frozen_string_literal: true

class BattlesController < ApplicationController
  def index
    @battles = Battle.all
    render json: { data: @battles }, status: :ok
  end

  def show
    @battles = Battle.find(params[:id])
  end

  def new
    @battle = Battle.new
  end
end
