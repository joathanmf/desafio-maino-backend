# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    true
  end

  def show?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end

  def xml_download?
    @user == @record.user
  end

  def danfe_download?
    @user == @record.user
  end
end
