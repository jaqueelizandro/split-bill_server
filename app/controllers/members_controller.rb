class MembersController < ApplicationController

    def index
        group = Group.find(params[:group_id])
        members = group.members
        render json: members
    end
    
    def create
        @member = Member.create!(name: params[:name], email: params[:email], group_id: params[:group_id])
        @group = Group.find(params[:group_id])
        @group.members << @member
        members = @group.members

        if @member.save
            MemberMailer.with(member: @member, group: @group).welcome_email.deliver_later
            render json: members, status: :created
        else
            render json: @member.errors, status: :unprocessable_entity
        end
        
    end

    def update
        group = Group.find(params[:group_id])
        member = group.members.find(params[:id])
        member.update!(name: params[:name], email: params[:email])
        
        if member.save
            MemberMailer.with(member: member).welcome_email.deliver_later
            render json: member, status: :created
        else
            render json: member.errors, status: :unprocessable_entity
        end

    end

    def destroy
        group = Group.find(params[:group_id])
        member = group.members.find(params[:id])
        member.destroy!
        render json: member, status: :no_content
    end
end