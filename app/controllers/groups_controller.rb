class GroupsController < ApplicationController

    def show
        group = Group.find(params[:id])
        render json: group, status: :created
    end

    def create
        group = Group.create(name: params[:name])
        render json: group, status: :created
    end
end