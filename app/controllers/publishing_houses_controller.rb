# frozen_string_literal: true

class PublishingHousesController < ApplicationController
  before_action :set_publishing_house, only: %i[show update destroy]

  # GET /publishing_houses
  def index
    @publishers = PublishingHouse.all
    json_response(@publishers)
  end

  # POST /publishing_houses
  def create
    @publisher = PublishingHouse.create!(publishing_house_params)
    json_response(@publisher, :created)
  end

  # GET /publishing_houses/:id
  def show
    json_response(@publisher)
  end

  # PUT /publishing_houses/:id
  def update
    @publisher.update(publishing_house_params)
    head :no_content
  end

  # DELETE /publishing_houses/:id
  def destroy
    @publisher.destroy
    head :no_content
  end

  private

  def publishing_house_params
    # whitelist params
    params.permit(:name)
  end

  def set_publishing_house
    @publisher = PublishingHouse.find(params[:id])
  end
  end
