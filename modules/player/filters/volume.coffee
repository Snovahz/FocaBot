AudioFilter = require './base'
{ isDJ } = Core.permissions

class VolumeFilter extends AudioFilter
  name: 'volume'
  display: '[Volume]'
  
  constructor: (@param, member)->
    throw "[Volume] Not enough permissions to use this filter" if not isDJ member
    @gain = parseInt(@param) or 2
    throw '[Volume] Gain must not be higher than 40' if gain > 40
    throw '[Volume] Gain must not be lower than -40' if gain< -40
    @FFMPEGFilter = @escape "volume=#{@gain}dB"
    @display = "[#{@gain}dB]"
    true
  
module.exports = VolumeFilter