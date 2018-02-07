class CockpitDetail < ApplicationRecord

  def self.set_cockpit_operation_fees(business)
    if business.cockpit? && business.cockpit_detail.present?
      promoter = CockpitPersonnelFee.find_by(name: "Promoter/Host Fee").amount * business.cockpit_detail.promoter_count
      pit_manager = CockpitPersonnelFee.find_by(name: "Pit Manager Fee").amount * business.cockpit_detail.pit_manager_count
      referee = CockpitPersonnelFee.find_by(name: "Referee Fee").amount * business.cockpit_detail.referee_count
      bet_taker = CockpitPersonnelFee.find_by(name: "Bet Taker Fee").amount * business.cockpit_detail.bet_taker_count
      bet_manager = CockpitPersonnelFee.find_by(name: "Bet Manager Fee").amount * business.cockpit_detail.bet_manager_count
      gaffer = CockpitPersonnelFee.find_by(name: "Gaffer Fee").amount * business.cockpit_detail.gaffer_count
      cashier = CockpitPersonnelFee.find_by(name: "Cashier Fee").amount * business.cockpit_detail.cashier_count
      derby = CockpitPersonnelFee.find_by(name: "Derby Fee").amount * business.cockpit_detail.derby_count
      amount = promoter + pit_manager + referee + bet_taker + bet_manager + gaffer + cashier + derby
    else
      0
    end
  end
end
