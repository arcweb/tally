module UserHelper
  def row_for_user(user)
    result = user.monthly_vacation_count.inject("<tr>") do |row, (key, value)|
      row += "<td class='#{value.humanize}'>#{value}</td>"
    end
    result += "<td>"
    result += "<a href='#{user_path(user)}' class='glyphicon glyphicon-remove archive-user-link' data-method='delete' data-user='#{user.firstname} #{user.lastname}'></a>"
    result += "<p class='user-total'>#{user.used_pto}/#{user.annual_pto}</p>"
    result += "</td></tr>"
  end
end
