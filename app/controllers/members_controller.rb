class MembersController < ApplicationController

    def index
        group = Group.find(params[:group_id])
        members = group.members
        render json: members
    end
    
    def create
        member = Member.create!(name: params[:name], email: params[:email])
        group = Group.find(params[:group_id])
        group.members << member
        members = group.members
        render json: members, status: :created
    end

    def update
        group = Group.find(params[:group_id])
        member = group.members.find(params[:id])
        member.update!(name: params[:name], email: params[:email])
        render json: member, status: :created
    end

    def destroy
        group = Group.find(params[:group_id])
        member = group.members.find(params[:id])
        member.destroy!
        render json: member, status: :no_content
    end
end