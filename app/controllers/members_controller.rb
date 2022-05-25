class MembersController < ApplicationController

    def index
        group = Group.find(params[:group_id])
        members = group.members
        render json: members
    end
    
    def create
        member = Member.create(name: params[:name], email: params[:email])
        group = Group.find(params[:group_id])
        group.members << member
        members = group.members
        render json: members, status: :created
    end
end
