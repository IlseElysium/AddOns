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
    if ( index > 5 and index < 11 and DropDownList1Button1.value == UnitName("player") ) then
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

function ChatFrame_OnEvent(event)
  if ( event == "UPDATE_CHAT_WINDOWS" ) then
    local name, fontSize, r, g, b, a, shown, locked = GetChatWindowInfo(this:GetID());
    if ( fontSize > 0 ) then
      local fontFile, unused, fontFlags = this:GetFont();
      this:SetFont(fontFile, fontSize, fontFlags);
    end
    if ( shown ) then
      this:Show();
    end
    -- Do more stuff!!!
    ChatFrame_RegisterForMessages(GetChatWindowMessages(this:GetID()));
    ChatFrame_RegisterForChannels(GetChatWindowChannels(this:GetID()));
    return;
  end
  if ( event == "PLAYER_ENTERING_WORLD" ) then
    this.defaultLanguage = GetDefaultLanguage();
    return;
  end
  if ( event == "TIME_PLAYED_MSG" ) then
    ChatFrame_DisplayTimePlayed(arg1, arg2);
    return;
  end
  if ( event == "PLAYER_LEVEL_UP" ) then
    -- Level up
    local info = ChatTypeInfo["SYSTEM"];
 
    local string = format(TEXT(LEVEL_UP), arg1);
    this:AddMessage(string, info.r, info.g, info.b, info.id);
 
    if ( arg3 > 0 ) then
      string = format(TEXT(LEVEL_UP_HEALTH_MANA), arg2, arg3);
    else
      string = format(TEXT(LEVEL_UP_HEALTH), arg2);
    end
    this:AddMessage(string, info.r, info.g, info.b, info.id);
 
    if ( arg4 > 0 ) then
      string = format(GetText("LEVEL_UP_CHAR_POINTS", nil, arg4), arg4);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
 
    if ( arg5 > 0 ) then
      string = format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT0_NAME), arg5);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    if ( arg6 > 0 ) then
      string = format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT1_NAME), arg6);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    if ( arg7 > 0 ) then
      string = format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT2_NAME), arg7);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    if ( arg8 > 0 ) then
      string = format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT3_NAME), arg8);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    if ( arg9 > 0 ) then
      string = format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT4_NAME), arg9);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    return;
  end
  if ( event == "CHARACTER_POINTS_CHANGED" ) then
    local info = ChatTypeInfo["SYSTEM"];
    if ( arg2 > 0 ) then
      local cp1, cp2 = UnitCharacterPoints("player");
      if ( cp2 ) then
        local string = format(GetText("LEVEL_UP_SKILL_POINTS", nil, cp2), cp2);
        this:AddMessage(string, info.r, info.g, info.b, info.id);
      end
    end
    return;
  end
  if ( event == "GUILD_MOTD" ) then
    if ( arg1 and (strlen(arg1) > 0) ) then
      local info = ChatTypeInfo["GUILD"];
      local string = format(TEXT(GUILD_MOTD_TEMPLATE), arg1);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    return;
  end
  if ( event == "EXECUTE_CHAT_LINE" ) then
    this.editBox:SetText(arg1);
    ChatEdit_SendText(this.editBox);
    ChatEdit_OnEscapePressed(this.editBox);
    return;
  end
  if ( event == "UPDATE_CHAT_COLOR" ) then
    local info = ChatTypeInfo[strupper(arg1)];
    if ( info ) then
      info.r = arg2;
      info.g = arg3;
      info.b = arg4;
      this:UpdateColorByID(info.id, info.r, info.g, info.b);
 
      if ( strupper(arg1) == "WHISPER" ) then
        info = ChatTypeInfo["REPLY"];
        if ( info ) then
          info.r = arg2;
          info.g = arg3;
          info.b = arg4;
          this:UpdateColorByID(info.id, info.r, info.g, info.b);
        end
      end
    end
    return;
  end
  if ( strsub(event, 1, 8) == "CHAT_MSG" ) then
    local type = strsub(event, 10);
    local info = ChatTypeInfo[type];
 
    local channelLength = strlen(arg4);
    if ( (strsub(type, 1, 7) == "CHANNEL") and (type ~= "CHANNEL_LIST") and ((arg1 ~= "INVITE") or (type ~= "CHANNEL_NOTICE_USER")) ) then
      local found = 0;
      for index, value in this.channelList do
        if ( channelLength > strlen(value) ) then
          -- arg9 is the channel name without the number in front...
          if ( ((arg7 > 0) and (this.zoneChannelList[index] == arg7)) or (strupper(value) == strupper(arg9)) ) then
            found = 1;
            info = ChatTypeInfo["CHANNEL"..arg8];
            if ( (type == "CHANNEL_NOTICE") and (arg1 == "YOU_LEFT") ) then
              this.channelList[index] = nil;
              this.zoneChannelList[index] = nil;
            end
            break;
          end
        end
      end
      if ( (found == 0) or not info ) then
        return;
      end
    end
 
    if ( type == "SYSTEM" or type == "TEXT_EMOTE" or type == "SKILL" or type == "LOOT" or type == "MONEY" ) then
      this:AddMessage(arg1, info.r, info.g, info.b, info.id);
    elseif ( strsub(type,1,7) == "COMBAT_" ) then
      this:AddMessage(arg1, info.r, info.g, info.b, info.id);
    elseif ( strsub(type,1,6) == "SPELL_" ) then
      this:AddMessage(arg1, info.r, info.g, info.b, info.id);
    elseif ( strsub(type,1,10) == "BG_SYSTEM_" ) then
      this:AddMessage(arg1, info.r, info.g, info.b, info.id);
    elseif ( type == "IGNORED" ) then
      this:AddMessage(format(TEXT(CHAT_IGNORED), arg2), info.r, info.g, info.b, info.id);
    elseif ( type == "FILTERED" ) then
      this:AddMessage(format(TEXT(CHAT_FILTERED), arg2), info.r, info.g, info.b, info.id);
    elseif ( type == "CHANNEL_LIST") then
      if(channelLength > 0) then
        this:AddMessage(format(TEXT(getglobal("CHAT_"..type.."_GET"))..arg1, arg4), info.r, info.g, info.b, info.id);
      else
        this:AddMessage(arg1, info.r, info.g, info.b, info.id);
      end
    elseif (type == "CHANNEL_NOTICE_USER") then
      if(strlen(arg5) > 0) then
        -- TWO users in this notice (E.G. x kicked y)
        this:AddMessage(format(TEXT(getglobal("CHAT_"..arg1.."_NOTICE")), arg4, arg2, arg5), info.r, info.g, info.b, info.id);
      else
        this:AddMessage(format(TEXT(getglobal("CHAT_"..arg1.."_NOTICE")), arg4, arg2), info.r, info.g, info.b, info.id);
      end
    elseif (type == "CHANNEL_NOTICE") then
      if ( arg10 > 0 ) then
        arg4 = arg4.." "..arg10;
      end
      this:AddMessage(format(TEXT(getglobal("CHAT_"..arg1.."_NOTICE")), arg4), info.r, info.g, info.b, info.id);
    else
      local body;
 
      -- Add AFK/DND flags
      local pflag;
      if(strlen(arg6) > 0) then
        pflag = TEXT(getglobal("CHAT_FLAG_"..arg6));
      else
        pflag = "";
      end
 
      local showLink = 1;
      if ( strsub(type, 1, 7) == "MONSTER" or type == "RAID_BOSS_EMOTE" ) then
        showLink = nil;
      else
        arg1 = gsub(arg1, "%%", "%%%%");
      end
      if ( (strlen(arg3) > 0) and (arg3 ~= "Universal") and (arg3 ~= this.defaultLanguage) ) then
        local languageHeader = "["..arg3.."] ";
        if ( showLink and (strlen(arg2) > 0) ) then
          body = format(TEXT(getglobal("CHAT_"..type.."_GET"))..languageHeader..arg1, pflag.."|Hplayer:"..arg2.."|h".."["..arg2.."]".."|h");
        else
          body = format(TEXT(getglobal("CHAT_"..type.."_GET"))..languageHeader..arg1, pflag..arg2);
        end
      else
        if ( showLink and (strlen(arg2) > 0) and (type ~= "EMOTE") ) then
          body = format(TEXT(getglobal("CHAT_"..type.."_GET"))..arg1, pflag.."|Hplayer:"..arg2.."|h".."["..arg2.."]".."|h");
        elseif ( type == "EMOTE" ) then
          body = format(TEXT(getglobal("CHAT_"..type.."_GET"))..arg1, pflag.."|Hplayer:"..arg2.."|h"..arg2.."|h");
        else
          body = format(TEXT(getglobal("CHAT_"..type.."_GET"))..arg1, pflag..arg2);
 
          -- Add raid boss emote message
          if ( type == "RAID_BOSS_EMOTE" ) then
            RaidBossEmoteFrame:AddMessage(body, info.r, info.g, info.b, 1.0);
          end
        end
      end
 
      -- Add Channel
      arg4 = gsub(arg4, "%s%-%s.*", "");
      if(channelLength > 0) then
        body = "["..arg4.."] "..body;
      end
      this:AddMessage(body, info.r, info.g, info.b, info.id);
    end
 
    if ( type == "WHISPER" ) then
      ChatEdit_SetLastTellTarget(this.editBox, arg2);
      if ( this.tellTimer and (GetTime() > this.tellTimer) ) then
        PlaySound("TellMessage");
      end
      this.tellTimer = GetTime() + CHAT_TELL_ALERT_TIME;
      FCF_FlashTab();
    end
    return;
  end
  if ( event == "ZONE_UNDER_ATTACK" ) then
    local info = ChatTypeInfo["SYSTEM"];
    this:AddMessage(format(TEXT(ZONE_UNDER_ATTACK), arg1), info.r, info.g, info.b, info.id);
    return;
  end
  if ( event == "UPDATE_INSTANCE_INFO" ) then
    if ( not RaidFrame.hasRaidInfo ) then
      return;
    end
    local info = ChatTypeInfo["SYSTEM"];
    if ( RaidFrame.slashCommand and GetNumSavedInstances() == 0 and this == DEFAULT_CHAT_FRAME) then
      this:AddMessage(TEXT(NO_RAID_INSTANCES_SAVED), info.r, info.g, info.b, info.id);
      RaidFrame.slashCommand = nil;
    end
  end
end