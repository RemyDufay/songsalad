module ApplicationHelper
  def guess_frequency(number)
    case
    when number < 8 then "bubble-guess"
    when (number >= 8) && (number < 11) then "bubble-guess-good"
    when number >= 11 then "bubble-guess-very-good"
    end
  end
end
