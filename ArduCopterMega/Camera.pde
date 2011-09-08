/// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-

//#if CAMERA_STABILIZER == ENABLED

static void init_camera()
{
	g.rc_camera_pitch.set_angle(4500);
	g.rc_camera_pitch.radio_min 	= 1200;
	g.rc_camera_pitch.radio_trim 	= 1500;
	g.rc_camera_pitch.radio_max 	= 1900;
	g.rc_camera_pitch.set_reverse(1);

	// ch 6 high right is down.


	g.rc_camera_roll.set_angle(4500);
	g.rc_camera_roll.radio_min 		= 1000;
	g.rc_camera_roll.radio_trim 	= 1500;
	g.rc_camera_roll.radio_max 		= 2000;

	g.rc_camera_roll.set_type(RC_CHANNEL_ANGLE_RAW);
	g.rc_camera_pitch.set_type(RC_CHANNEL_ANGLE_RAW);
}

static void
camera_stabilization()
{
	// PITCH
	// -----
	// allow control mixing
	g.rc_camera_pitch.set_pwm(APM_RC.InputCh(CH_6)); // I'm using CH 6 input here.
	g.rc_camera_pitch.servo_out = g.rc_camera_pitch.control_mix(-dcm.pitch_sensor);
	// limit
	g.rc_camera_pitch.servo_out = constrain(g.rc_camera_pitch.servo_out, -4500, 4500);

	// dont allow control mixing
	/*
	g.rc_camera_pitch.servo_out = dcm.pitch_sensor  * -1;
	*/


	// ROLL
	// -----
	// allow control mixing
	/*
	g.rc_camera_roll.set_pwm(APM_RC.InputCh(CH_6)); // I'm using CH 6 input here.
	g.rc_camera_roll.servo_out = g.rc_camera_roll.control_mix(-dcm.roll_sensor);
	*/

	// dont allow control mixing
	// limit
	g.rc_camera_roll.servo_out = constrain(-dcm.roll_sensor, -4500, 4500);



	// Output
	// ------
	g.rc_camera_pitch.calc_pwm();
	g.rc_camera_roll.calc_pwm();

	APM_RC.OutputCh(CH_5, g.rc_camera_pitch.radio_out);
	APM_RC.OutputCh(CH_6, g.rc_camera_roll.radio_out);
	//Serial.printf("c:%d\n",  g.rc_camera_pitch.radio_out);
}

//#endif
