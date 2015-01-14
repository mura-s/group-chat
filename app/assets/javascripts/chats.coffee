# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".my-group").click ->
    # alert
    $("p.alert").remove()

    # 参加グループ
    $(".my-group.active").removeClass("active")
    $(this).addClass("active")

    # チャットエリア
    $(".send-button").removeClass("disabled")

    # グループ編集、抜ける
    group_id = $(this).attr("id")
    $(".group-setting,.leave-group").removeClass("disabled")
    $(".group-setting").attr("href", "/groups/#{group_id}/edit")
    $(".leave-group").attr("href", "/groups/#{group_id}/leave")

    # メンバー
    create_member_area(group_id)

  create_member_area = (group_id) ->
    $(".group-member").empty()
    $.get "/api/groups/#{group_id}/members", (data) ->
      for member in data.members
        $(".group-member").append("<li class='list-group-item'>#{member.name}</li>")


