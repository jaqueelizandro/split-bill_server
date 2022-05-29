class GroupsController < ApplicationController

    def show
        group = Group.find(params[:id])
        # members = group.members
        render json: group
    end

    def create
        group = Group.create(name: params[:name])
        render json: group, status: :created
    end
end