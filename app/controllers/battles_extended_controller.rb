# frozen_string_literal: true

class BattlesExtendedController < BattlesController
  def create
    # params: battle = { monsterA_id, monsterB_id}
    if params['battle']['monsterA_id'].blank? || params['battle']['monsterB_id'].blank?
      #  need 2 monsters
      render json: { message: 'Two monsters required' }, status: :unprocessable_entity
      return
    end
    monsterA = Monster.where(id: params['battle']['monsterA_id']).first 
    monsterB = Monster.where(id: params['battle']['monsterB_id']).first
    if !monsterA || !monsterB
      # both monsters must exist
      render json: { message: 'Both monsters must exist' }, status: :unprocessable_entity
      return
    end

    @battle = Battle.new
    @battle.monsterA_id = monsterA.id
    @battle.monsterB_id = monsterB.id
    # let the battle begin
    @battle = BattlesExtendedService.new.fight(@battle)
    
    if @battle.save
      render json: { data: @battle }, status: :created
    else
      render json: { message: 'Battle not saved' }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @battle = Battle.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { message: 'The battle does not exists.' }, status: :not_found
    end

    if @battle.destroy
      redirect_to root_path, status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

end
