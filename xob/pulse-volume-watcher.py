#!/usr/bin/env python3
from pulsectl import Pulse, PulseLoopStop
import sys, os

# Adapt to your use-case
# sink_id = os.getenv("PULSE_SINK")
# sink_id = os.system("pactl list sinks | grep -B 2 'RUNNING' | grep -Eo '[0-9][0-9]?'")
sink_id = 1

with Pulse() as pulse:
    def callback(ev):
        if ev.index == sink_id:
            raise PulseLoopStop

    try:
        pulse.event_mask_set('sink')
        pulse.event_callback_set(callback)
        last_value = round(pulse.sink_list()[sink_id].volume.value_flat * 100)
        last_mute = pulse.sink_list()[sink_id].mute == 1

        while True:
            print("ID:", sink_id)
            pulse.event_listen()
            value = round(pulse.sink_list()[sink_id].volume.value_flat * 100)
            mute = pulse.sink_list()[sink_id].mute == 1

            if value != last_value or mute != last_mute:
                print(value, end='')
                if mute:
                    print('!')
                else:
                    print('')
                last_value = value
                last_mute = mute
            sys.stdout.flush()

    except:
        pass
