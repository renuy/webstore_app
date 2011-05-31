module QuizzesHelper

  def get_ans(quiz, opt)
    case opt
      when 1 then 
        case quiz.cue
          when 'author' then quiz.title.author.name.upcase
          when 'title' then quiz.title.title.upcase
          else quiz.answer.upcase
        end
        
      when 2 then quiz.option_1.upcase
      when 3 then quiz.option_2.upcase
      when 4 then quiz.option_3.upcase
    end
  end
  def get_opts
    opt = []
    opt << [1,2,3,4]
    opt <<[1,2,4,3]
    opt <<[1,3,2,4]
    opt <<[1,3,4,2]
    opt <<[1,4,3,2]
    opt <<[1,4,2,3]

    opt <<[2,1,3,4]
    opt <<[2,1,4,3]
    opt <<[2,3,4,1]
    opt <<[2,3,1,4]
    opt <<[2,4,3,1]
    opt <<[2,4,1,3]

    opt <<[3,2,1,4]
    opt <<[3,1,2,4]
    opt <<[3,4,1,2]
    opt <<[3,4,2,1]
    opt <<[3,1,4,2]
    opt <<[3,2,4,1]


    opt <<[4,2,3,1]
    opt <<[4,2,1,3]
    opt <<[4,1,2,3]
    opt <<[4,1,3,2]
    opt <<[4,3,2,1]
    opt <<[4,3,1,2]
    
    return opt[rand(opt.size)]
  end
end
