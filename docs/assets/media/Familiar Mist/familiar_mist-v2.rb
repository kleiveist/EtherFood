# DURCH DEN ERSTEN NEBEL
# 16-Bit-Fantasy-RPG-Szenenmusik

use_bpm 96
use_debug false
set_volume! 1.1

define :mist_chord do |notes|
  use_synth :hollow
  
  notes.each do |n|
    play n,
      attack: 1.4,
      sustain: 1.8,
      release: 2.5,
      cutoff: 78,
      amp: 0.28
  end
end

# Gemeinsamer Taktgeber
live_loop :mist_clock do
  cue :new_bar
  sleep 4
end

# Nebel und leises Rauschen
live_loop :fog_wind do
  sync :new_bar
  
  with_fx :reverb, room: 1, mix: 0.85 do
    with_fx :lpf, cutoff: 68 do
      synth :bnoise,
        attack: 1.5,
        sustain: 2.5,
        release: 2,
        amp: 0.045
    end
  end
end

# Langsame, schwebende Harmonien
live_loop :fog_harmony do
  sync :new_bar
  
  progression = [
    [:e3, :b3, :fs4],
    [:c3, :g3, :b3, :e4],
    [:g2, :d3, :a3, :b3],
    [:d3, :a3, :e4, :fs4]
  ]
  
  with_fx :reverb, room: 0.95, mix: 0.65 do
    progression.each do |notes|
      mist_chord notes
      sleep 4
    end
  end
end

# Schritte durch den Nebel
live_loop :fog_steps do
  sync :new_bar
  use_synth :tri
  
  8.times do
    play [:e2, :e2, :g2, :d2].tick(:steps),
      release: 0.16,
      cutoff: 60,
      amp: 0.16
    
    sleep 0.5
  end
end

# Zögerliche Hauptmelodie
live_loop :mist_melody do
  sync :new_bar
  use_synth :pulse
  
  melody = [
    [:e4, 0.75], [:g4, 0.75],
    [:b4, 1.0],  [:fs4, 0.5],
    [:e4, 1.0],  [:r, 0.5],
    [:d4, 0.5],  [:e4, 1.0],
    
    [:g4, 0.75], [:a4, 0.75],
    [:b4, 1.0],  [:d5, 0.5],
    [:b4, 1.0],  [:r, 0.5],
    [:a4, 0.5],  [:fs4, 1.0]
  ]
  
  with_fx :echo, phase: 0.75, decay: 3, mix: 0.32 do
    with_fx :reverb, room: 0.85, mix: 0.5 do
      melody.each do |note, duration|
        unless note == :r
          play note,
            attack: 0.03,
            release: duration * 0.8,
            cutoff: 82,
            amp: 0.32
        end
        
        sleep duration
      end
    end
  end
end

# Dumpfes Nebelrauschen im Hintergrund
live_loop :deep_fog_noise do
  sync :new_bar
  
  with_fx :reverb, room: 1, mix: 0.75 do
    with_fx :lpf, cutoff: 52 do
      synth :bnoise,
        attack: 2.5,
        sustain: 5,
        release: 3.5,
        amp: 0.4,
        pan: rrand(-0.15, 0.15)
    end
  end
  
  sleep 8
end

# Unbekannte Lichtpunkte im Nebel
live_loop :distant_signs do
  sync :new_bar
  sleep [1.5, 2, 2.5, 3].choose
  
  use_synth :pretty_bell
  
  with_fx :echo, phase: 1, decay: 4, mix: 0.5 do
    play scale(:e5, :minor_pentatonic, num_octaves: 2).choose,
      release: 1.6,
      amp: 0.12
  end
  
  sleep 4
end

