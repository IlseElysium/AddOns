ChatFrameEditBox.chatType = "GUILD";
ChatFrameEditBox.stickyType = "GUILD";

UnitPopupButtons["GONAME"] = { text = "Goname", dist = 0 };
UnitPopupButtons["NAMEGO"] = { text = "Namego", dist = 0 };
UnitPopupButtons["KICK"] = { text = "Kick", dist = 0 };
UnitPopupButtons["RENAME"] = { text = "Rename", dist = 0 };
UnitPopupButtons["BAN"] = { text = "Ban", dist = 0 };

UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "TARGET", "GUILD_PROMOTE", "GUILD_LEAVE", "GONAME", "NAMEGO", "KICK", "RENAME", "BAN", "CANCEL" };

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

StaticPopupDialogs["RENAME"] = {
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
  elseif ( button == "RENAME" ) then
    StaticPopupDialogs["RENAME"].text = "Rename player "..DropDownList1Button1.value.."?";
    StaticPopupDialogs["RENAME"].OnAccept = function()
      SendChatMessage(".character rename "..DropDownList1Button1.value, "GUILD");
    end;
    StaticPopup_Show("RENAME");
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

function UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
  -- Init variables
  dropdownMenu.which = which;
  dropdownMenu.unit = unit;
  if ( unit and not name ) then
    name, server = UnitName(unit, true);
  end
  dropdownMenu.name = name;
  dropdownMenu.userData = userData;
  dropdownMenu.server = server;
 
  -- Determine which buttons should be shown or hidden
  UnitPopup_HideButtons();
 
  -- If only one menu item (the cancel button) then don't show the menu
  local count = 0;
  for index, value in UnitPopupMenus[which] do
    if( UnitPopupShown[index] == 1 and value ~= "CANCEL" ) then
      count = count + 1;
    end
  end
  if ( count < 1 ) then
    return;
  end
 
  -- Determine which loot method and which loot threshold are selected and set the corresponding buttons to the same text
  dropdownMenu.selectedLootMethod = UnitLootMethod[GetLootMethod()].text;
  UnitPopupButtons["LOOT_METHOD"].text = dropdownMenu.selectedLootMethod;
  UnitPopupButtons["LOOT_METHOD"].tooltipText = UnitLootMethod[GetLootMethod()].tooltipText;
  dropdownMenu.selectedLootThreshold = getglobal("ITEM_QUALITY"..GetLootThreshold().."_DESC");
  UnitPopupButtons["LOOT_THRESHOLD"].text = dropdownMenu.selectedLootThreshold;
  -- This allows player to view loot settings if he's not the leader
  if ( ((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0)) and IsPartyLeader() ) then
    -- If this is true then player is the party leader
    UnitPopupButtons["LOOT_METHOD"].nested = 1;
    UnitPopupButtons["LOOT_THRESHOLD"].nested = 1;
  else
    UnitPopupButtons["LOOT_METHOD"].nested = nil;
    UnitPopupButtons["LOOT_THRESHOLD"].nested = nil;
  end
 
  -- If level 2 dropdown
  local info;
  local color;
  local icon;
  if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
    dropdownMenu.which = UIDROPDOWNMENU_MENU_VALUE;
    -- Set which menu is being opened
    OPEN_DROPDOWNMENUS[UIDROPDOWNMENU_MENU_LEVEL] = {which = dropdownMenu.which, unit = dropdownMenu.unit};
    for index, value in UnitPopupMenus[UIDROPDOWNMENU_MENU_VALUE] do
      info = {};
      info.text = UnitPopupButtons[value].text;
      info.owner = UIDROPDOWNMENU_MENU_VALUE;
      -- Set the text color
      color = UnitPopupButtons[value].color;
      if ( color ) then
        info.textR = color.r;
        info.textG = color.g;
        info.textB = color.b;
      end
      -- Icons
      info.icon = UnitPopupButtons[value].icon;
      info.tCoordLeft = UnitPopupButtons[value].tCoordLeft;
      info.tCoordRight = UnitPopupButtons[value].tCoordRight;
      info.tCoordTop = UnitPopupButtons[value].tCoordTop;
      info.tCoordBottom = UnitPopupButtons[value].tCoordBottom;
      -- Checked conditions
      if ( info.text == dropdownMenu.selectedLootMethod  ) then
        info.checked = 1;
      elseif ( info.text == dropdownMenu.selectedLootThreshold ) then
        info.checked = 1;
      elseif ( strsub(value, 1, 12) == "RAID_TARGET_" ) then
        local raidTargetIndex = GetRaidTargetIndex(unit);
        if ( raidTargetIndex == index ) then
          info.checked = 1;
        end
      end
     
      info.value = value;
      info.func = UnitPopup_OnClick;
      -- Setup newbie tooltips
      info.tooltipTitle = UnitPopupButtons[value].text;
      info.tooltipText = getglobal("NEWBIE_TOOLTIP_UNIT_"..value);
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
    end
    return;    
  end
 
  -- Add dropdown title
  if ( unit or name ) then
    info = {};
    if ( name ) then
      info.text = name;
    else
      info.text = TEXT(UNKNOWN);
    end
    info.isTitle = 1;
    info.notCheckable = 1;
    UIDropDownMenu_AddButton(info);
  end
 
  -- Set which menu is being opened
  OPEN_DROPDOWNMENUS[UIDROPDOWNMENU_MENU_LEVEL] = {which = dropdownMenu.which, unit = dropdownMenu.unit};
  -- Show the buttons which are used by this menu
  local tooltipText;
  for index, value in UnitPopupMenus[which] do
    if ( index > 5 and index < 10 and DropDownList1Button1.value == UnitName("player") ) then
      UnitPopupShown[index] = 0;
    end
    if ( UnitPopupShown[index] == 1 ) then
      info = {};
      info.text = UnitPopupButtons[value].text;
      info.value = value;
      info.owner = which;
      info.func = UnitPopup_OnClick;
      if ( not UnitPopupButtons[value].checkable ) then
        info.notCheckable = 1;
      end
      -- Text color
      if ( value == "LOOT_THRESHOLD" ) then
        -- Set the text color
        color = ITEM_QUALITY_COLORS[GetLootThreshold()];
        info.textR = color.r;
        info.textG = color.g;
        info.textB = color.b;
      else
        color = UnitPopupButtons[value].color;
        if ( color ) then
          info.textR = color.r;
          info.textG = color.g;
          info.textB = color.b;
        end
      end
      -- Icons
      info.icon = UnitPopupButtons[value].icon;
      info.tCoordLeft = UnitPopupButtons[value].tCoordLeft;
      info.tCoordRight = UnitPopupButtons[value].tCoordRight;
      info.tCoordTop = UnitPopupButtons[value].tCoordTop;
      info.tCoordBottom = UnitPopupButtons[value].tCoordBottom;
      -- Checked conditions
      if ( strsub(value, 1, 12) == "RAID_TARGET_" ) then
        local raidTargetIndex = GetRaidTargetIndex("target");
        if ( raidTargetIndex == index ) then
          info.checked = 1;
        end
      end
      if ( UnitPopupButtons[value].nested ) then
        info.hasArrow = 1;
      end
     
      -- Setup newbie tooltips
      info.tooltipTitle = UnitPopupButtons[value].text;
      tooltipText = getglobal("NEWBIE_TOOLTIP_UNIT_"..value);
      if ( not tooltipText ) then
        tooltipText = UnitPopupButtons[value].tooltipText;
      end
      info.tooltipText = tooltipText;
      UIDropDownMenu_AddButton(info);
    end
  end
  PlaySound("igMainMenuOpen");
end