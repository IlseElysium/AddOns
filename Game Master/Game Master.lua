ChatFrameEditBox.chatType = "GUILD";
ChatFrameEditBox.stickyType = "GUILD";

UnitPopupButtons["GONAME"] = { text = "Goname", dist = 0 };
UnitPopupButtons["NAMEGO"] = { text = "Namego", dist = 0 };
UnitPopupButtons["KICK"] = { text = "Kick", dist = 0 };
UnitPopupButtons["BAN"] = { text = "Ban", dist = 0 };

UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "TARGET", "GUILD_PROMOTE", "GUILD_LEAVE", "GONAME", "NAMEGO", "KICK", "BAN", "CANCEL" };

StaticPopupDialogs["NAMEGO"] = {
  button1 = "Yes",
  button2 = "No",
  hideOnEscape = 1,
  showAlert = 1,
  timeout = 0
};

StaticPopupDialogs["KICK"] = {
  button1 = "Yes",
  button2 = "No",
  hideOnEscape = 1,
  showAlert = 1,
  timeout = 0
};

StaticPopupDialogs["BAN"] = {
  button1 = "Ban",
  button2 = "Cancel",
  EditBoxOnEscapePressed = function()
    StaticPopup_Hide("BAN");
  end,
  hasEditBox = 1,
  hideOnEscape = 1,
  maxLetters = 99,
  showAlert = 1,
  timeout = 0
};

function UnitPopup_OnClick()
  local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
  local button = this.value;
  local unit = dropdownFrame.unit;
  local name = dropdownFrame.name;
  local server = dropdownFrame.server;
 
  if ( button == "TRADE" ) then
    InitiateTrade(unit);
  elseif ( button == "WHISPER" ) then
    if(server) then
      ChatFrame_SendTell(name.."-"..server);
    else
      ChatFrame_SendTell(name)
    end
  elseif ( button == "INSPECT" ) then
    InspectUnit(unit);
  elseif ( button == "TARGET" ) then
    if ( server ) then
      TargetByName(name.."-"..server, 1);
    else
      TargetByName(name, 1);
    end
  elseif ( button == "DUEL" ) then
    StartDuelUnit(unit);
  elseif ( button == "INVITE" ) then
    if ( unit ) then
      InviteToParty(unit);
    else
      InviteByName(name);
    end
  elseif ( button == "UNINVITE" ) then
    UninviteFromParty(unit);
  elseif ( button == "PROMOTE" ) then
    PromoteToPartyLeader(unit);
  elseif ( button == "GUILD_PROMOTE" ) then
    local dialog = StaticPopup_Show("CONFIRM_GUILD_PROMOTE", name);
    dialog.data = name;
  elseif ( button == "GUILD_LEAVE" ) then
    StaticPopup_Show("CONFIRM_GUILD_LEAVE", GetGuildInfo("player"));
  elseif ( button == "GONAME" ) then
    SendChatMessage(".goname "..DropDownList1Button1.value, "GUILD");
  elseif ( button == "NAMEGO" ) then
    StaticPopupDialogs["NAMEGO"].text = "Teleport player "..DropDownList1Button1.value.." to you?";
    StaticPopupDialogs["NAMEGO"].OnAccept = function()
      SendChatMessage(".namego "..DropDownList1Button1.value, "GUILD");
    end;
    StaticPopup_Show("NAMEGO");
  elseif ( button == "KICK" ) then
    StaticPopupDialogs["KICK"].text = "Kick player "..DropDownList1Button1.value.."?";
    StaticPopupDialogs["KICK"].OnAccept = function()
      SendChatMessage(".kick "..DropDownList1Button1.value, "GUILD");
    end;
    StaticPopup_Show("KICK");
  elseif ( button == "BAN" ) then
    StaticPopupDialogs["BAN"].text = "Ban player "..DropDownList1Button1.value.." for:";
    StaticPopupDialogs["BAN"].OnAccept = function()
      local info = ChatTypeInfo["SYSTEM"];
      ChatFrame1:AddMessage("Ban option unavailable.", info.r, info.g, info.b, info.id);
      --SendChatMessage(".ban character "..DropDownList1Button1.value.." -1 $reason", "GUILD");
    end;
    StaticPopup_Show("BAN");
  elseif ( button == "LEAVE" ) then
    LeaveParty();
  elseif ( button == "PET_PASSIVE" ) then
    PetPassiveMode();
  elseif ( button == "PET_DEFENSIVE" ) then
    PetDefensiveMode();
  elseif ( button == "PET_AGGRESSIVE" ) then
    PetAggressiveMode();
  elseif ( button == "PET_WAIT" ) then
    PetWait();
  elseif ( button == "PET_FOLLOW" ) then
    PetFollow();
  elseif ( button == "PET_ATTACK" ) then
    PetAttack();
  elseif ( button == "PET_DISMISS" ) then
    PetDismiss();
  elseif ( button == "PET_ABANDON" ) then
    StaticPopup_Show("ABANDON_PET");
  elseif ( button == "PET_PAPERDOLL" ) then
    ToggleCharacter("PetPaperDollFrame");
  elseif ( button == "PET_RENAME" ) then
    StaticPopup_Show("RENAME_PET");
  elseif ( button == "FREE_FOR_ALL" ) then
    SetLootMethod("freeforall");
    UIDropDownMenu_SetButtonText(1, 2, UnitPopupButtons[button].text);
    UIDropDownMenu_Refresh(dropdownFrame, nil, 1);
  elseif ( button == "ROUND_ROBIN" ) then
    SetLootMethod("roundrobin");
    UIDropDownMenu_SetButtonText(1, 2, UnitPopupButtons[button].text);
    UIDropDownMenu_Refresh(dropdownFrame, nil, 1);
  elseif ( button == "MASTER_LOOTER" ) then
    SetLootMethod("master", name);
    UIDropDownMenu_SetButtonText(1, 2, UnitPopupButtons[button].text);
    UIDropDownMenu_Refresh(dropdownFrame, nil, 1);
  elseif ( button == "GROUP_LOOT" ) then
    SetLootMethod("group");
    UIDropDownMenu_SetButtonText(1, 2, UnitPopupButtons[button].text);
    UIDropDownMenu_Refresh(dropdownFrame, nil, 1);
  elseif ( button == "NEED_BEFORE_GREED" ) then
    SetLootMethod("needbeforegreed");
    UIDropDownMenu_SetButtonText(1, 2, UnitPopupButtons[button].text);
    UIDropDownMenu_Refresh(dropdownFrame, nil, 1);
  elseif ( button == "LOOT_PROMOTE" ) then
    SetLootMethod("master", name);
  elseif ( button == "RESET_INSTANCES" ) then
    StaticPopup_Show("CONFIRM_RESET_INSTANCES");
  elseif ( button == "FOLLOW" ) then
    FollowByName(name, 1);
  elseif ( button == "RAID_LEADER" ) then
    PromoteByName(name);
  elseif ( button == "RAID_PROMOTE" ) then
    PromoteToAssistant(name);
  elseif ( button == "RAID_DEMOTE" ) then
    DemoteAssistant(name);
  elseif ( button == "RAID_REMOVE" ) then
    UninviteFromRaid(dropdownFrame.userData);
  elseif ( button == "ITEM_QUALITY2_DESC" or button == "ITEM_QUALITY3_DESC" or button == "ITEM_QUALITY4_DESC" ) then
    SetLootThreshold(this:GetID()+1);
    color = ITEM_QUALITY_COLORS[this:GetID()+1];
    UIDropDownMenu_SetButtonText(1, 3, UnitPopupButtons[button].text, color.r, color.g, color.b);
  elseif ( strsub(button, 1, 12) == "RAID_TARGET_" and button ~= "RAID_TARGET_ICON" ) then
    local raidTargetIndex = strsub(button, 13);
    if ( raidTargetIndex == "NONE" ) then
      raidTargetIndex = 0;
    end
    SetRaidTargetIcon(unit, tonumber(raidTargetIndex));
  end
  PlaySound("UChatScrollButton");
end