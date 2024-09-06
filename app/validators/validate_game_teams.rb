class ValidateGameTeams < ActiveModel::Validator
    def validate(record)
       if !record.team_1 && !record.team_2
         record.errors.add :teams, "Select a team"
       elsif record.team_1 === record.team_2
        record.errors.add :teams, "can't be the same"
       end
    end
end