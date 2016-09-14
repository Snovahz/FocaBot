AudioFilter = require '../models/audioFilter'
moment = require 'moment'

class TempoFilter extends AudioFilter
  processTime: (time)=> time / parseFloat(@param)
  originalTime: (time)=> time * parseFloat(@param)

  validate:=>
    speed = parseFloat @param 
    return 'Requested speed is not a number.' if not speed
    return 'Speed must not be higher than 4' if speed > 4
    return 'Speed must not be lower than 0.25' if speed < 0.25
    
  toFFMPEGFilter:=> @escape "atempo=#{parseFloat(@param)}"
  toString:=> "[#{@param}x Tempo]"
  
module.exports = TempoFilter