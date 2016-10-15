###
The Main Server Class
###
Discordie = require 'discordie'
CommandManager = require './commands'
ModuleManager = require './modules'
PermissionManager = require './permissions'
GuildManager = require './guilds'
WebHookCollection = require './webHooks'
git = require 'git-rev'
thinky = require './thinky'

class BotEngine
  constructor: (@settings) ->
    {@prefix, @name} = @settings
    global.Core = @
    @bot = new Discordie { autoReconnect: true }
    @db = thinky
    @guildData = new GuildManager @
    @permissions = new PermissionManager @
    @commands = new CommandManager @
    @modules = new ModuleManager @
    @webHooks = new WebHookCollection @
    @bot.Dispatcher.on 'GATEWAY_READY', @onReady
    @bot.Dispatcher.on 'MESSAGE_CREATE', @onMessage
    @bootDate = new Date()
    git.short @devVersion
    @version = "0.5.2"
    
  onReady: (e)=>
    @bot.User.setStatus 'dnd', {
      name: "#{@prefix}help [dev-0.5.2]"
    } 
    console.log 'Connected.'

  onMessage: (e)=>
    @commands.executeCommand e.message

  devVersion: (version)=>
    @versionName = 'git-'+version

  establishConnection: => @bot.connect { token: @settings.token }

  getGuildData: (guild)=> @guildData.getGuild guild

module.exports = BotEngine
