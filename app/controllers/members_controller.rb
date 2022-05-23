class MembersController < ApplicationController

    def create
        member = Member.create(name: params[:name], email: params[:email])
        group = Group.find(params[:group_id])
        group.members << member
        members = group.members
        render json: members, status: :created
    end
end
