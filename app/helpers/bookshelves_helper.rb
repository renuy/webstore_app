module BookshelvesHelper
  def isHoldingBooks(card)
    bs = Bookshelf.find_all_by_membership_no(card.card_id).count

    if bs > 0
      true
    else
      false
    end
  end

  def getHoldingBooks(card)
    Bookshelf.find_all_by_membership_no(card.card_id)
  end

end
