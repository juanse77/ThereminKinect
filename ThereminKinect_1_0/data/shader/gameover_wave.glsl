
#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;
uniform float score;

uniform sampler2D texture ;
varying vec4 vertTexCoord ;

//-- MOJI
vec2 uv;

const vec2 ch_size  = vec2(1.0, 2.0);              // character size (X,Y)
const vec2 ch_space = ch_size + vec2(1.0, 1.0);    // character distance Vector(X,Y)
const vec2 ch_start = vec2 (ch_space.x * -6., 2.); // start position
      vec2 ch_pos   = vec2 (0.0, 0.0);             // character position(X,Y)
      vec3 ch_color = vec3 (4.9, 3.0, 2.5);        // character color (R,G,B)
      vec3 bg_color = vec3 (0.0, 0.0, 0.0);        // background color (R,G,B)

#define REPEAT_SIGN false // True/False; True=Multiple, False=Single
#define n0 ddigit(0x22FF);
#define n1 ddigit(0x0281);
#define n2 ddigit(0x1177);
#define n3 ddigit(0x11E7);
#define n4 ddigit(0x1189);
#define n5 ddigit(0x11EE);
#define n6 ddigit(0x11FE);
#define n7 ddigit(0x0087);
#define n8 ddigit(0x11FF);
#define n9 ddigit(0x11EF);
#define A ddigit(0x119F);
#define B ddigit(0x927E);
#define C ddigit(0x007E);
#define D ddigit(0x44E7);
#define E ddigit(0x107E);
#define F ddigit(0x101E);
#define G ddigit(0x807E);
#define H ddigit(0x1199);
#define I ddigit(0x4466);
#define J ddigit(0x4436);
#define K ddigit(0x9218);
#define L ddigit(0x0078);
#define M ddigit(0x0A99);
#define N ddigit(0x8899);
#define O ddigit(0x00FF);
#define P ddigit(0x111F);
#define Q ddigit(0x80FF);
#define R ddigit(0x911F);
#define S ddigit(0x8866);
#define T ddigit(0x4406);
#define U ddigit(0x00F9);
#define V ddigit(0x2218);
#define W ddigit(0xA099);
#define X ddigit(0xAA00);
#define Y ddigit(0x4A00);
#define Z ddigit(0x2266);
#define _ ch_pos.x += ch_space.x;
#define s_dot     ddigit(0);
#define s_minus   ddigit(0x1100);
#define s_plus    ddigit(0x5500);
#define s_greater ddigit(0x2800);
#define s_less    ddigit(0x8200);
#define s_sqrt    ddigit(0x0C02);
#define barra     ddigit(0x2200);
#define nl1 ch_pos = ch_start;  ch_pos.y -= 3.0;
#define nl2 ch_pos = ch_start;  ch_pos.y -= 6.0;
#define nl3 ch_pos = ch_start;	ch_pos.y -= 9.0;

float log10(float x) {
  return log(x)/log(10.0);
}

float dseg(vec2 p0, vec2 p1)
{
	vec2 dir = normalize(p1 - p0);
	vec2 cp = (uv - ch_pos - p0) * mat2(dir.x, dir.y,-dir.y, dir.x);
	return distance(cp, clamp(cp, vec2(0), vec2(distance(p0, p1), 0)));
}

bool bit(int n, int b)
{
	return mod(floor(float(n) / exp2(floor(float(b)))), 2.) != 0.0;
}

float d = 1e6;

void ddigit(int n)
{
	float v = 1e6;
	vec2 cp = uv - ch_pos;
	if (n == 0)     v = min(v, dseg(vec2(-0.405, -1.000), vec2(-0.500, -1.000)));
	if (bit(n,  0)) v = min(v, dseg(vec2( 0.500,  0.063), vec2( 0.500,  0.937)));
	if (bit(n,  1)) v = min(v, dseg(vec2( 0.438,  1.000), vec2( 0.063,  1.000)));
	if (bit(n,  2)) v = min(v, dseg(vec2(-0.063,  1.000), vec2(-0.438,  1.000)));
	if (bit(n,  3)) v = min(v, dseg(vec2(-0.500,  0.937), vec2(-0.500,  0.062)));
	if (bit(n,  4)) v = min(v, dseg(vec2(-0.500, -0.063), vec2(-0.500, -0.938)));
	if (bit(n,  5)) v = min(v, dseg(vec2(-0.438, -1.000), vec2(-0.063, -1.000)));
	if (bit(n,  6)) v = min(v, dseg(vec2( 0.063, -1.000), vec2( 0.438, -1.000)));
	if (bit(n,  7)) v = min(v, dseg(vec2( 0.500, -0.938), vec2( 0.500, -0.063)));
	if (bit(n,  8)) v = min(v, dseg(vec2( 0.063,  0.000), vec2( 0.438, -0.000)));
	if (bit(n,  9)) v = min(v, dseg(vec2( 0.063,  0.063), vec2( 0.438,  0.938)));
	if (bit(n, 10)) v = min(v, dseg(vec2( 0.000,  0.063), vec2( 0.000,  0.937)));
	if (bit(n, 11)) v = min(v, dseg(vec2(-0.063,  0.063), vec2(-0.438,  0.938)));
	if (bit(n, 12)) v = min(v, dseg(vec2(-0.438,  0.000), vec2(-0.063, -0.000)));
	if (bit(n, 13)) v = min(v, dseg(vec2(-0.063, -0.063), vec2(-0.438, -0.938)));
	if (bit(n, 14)) v = min(v, dseg(vec2( 0.000, -0.938), vec2( 0.000, -0.063)));
	if (bit(n, 15)) v = min(v, dseg(vec2( 0.063, -0.063), vec2( 0.438, -0.938)));
	ch_pos.x += ch_space.x;
	d = min(d, v);
}

void digito(int digito) {
  switch(digito)
  {
    case 0:
      n0
      break;
    case 1:
      n1
      break;
    case 2:
      n2
      break;
    case 3:
      n3
      break;
    case 4:
      n4
      break;
    case 5:
      n5
      break;
    case 6:
      n6
      break;
    case 7:
      n7
      break;
    case 8:
      n8
      break;
    case 9:
      n9
      break;
    default:
      break;
  }
}

void create_number(float number, int nDigits, int nDecimals) {
  float num = number;

  // Stack integer characters
  int stack = 0;
  for(int i = 0; i < nDigits; i++) {
    int character = int(mod(num, 10.0));
    num = num / 10.0;

    stack += character; // push stack
    stack *= 10; // move pointer up
  }
  stack /= 10; // move pointer down

  // Create integer characters
  for(int i = 0; i < nDigits; i++) {
    int character = int(mod(float(stack), 10.0));

    digito(character);

    stack /= 10;
  }

  s_dot // punto decimal

  // Create decimals characters
  num = number - int(number);

  for(int i = 0; i < nDecimals; i++) {
    num *= 10;
    int character = int(mod(num, 10));

    digito(character);
  }
}

void create_number(float number, int nDecimals) {
  int digits = (int(number)) == 0 ? 1 : int(log10(number)+1) ;
  create_number(number, digits, nDecimals);
}

void main( void )
{
  bg_color = texture2D( texture , vertTexCoord.st + vec2( 0.0 , 0.0) ).rgb;

  bg_color += vec3(0., 0.5, 0.);

	//--MOJI
	vec2 aspect = resolution.xy / resolution.y;
	uv = ( gl_FragCoord.xy / resolution.y ) - aspect / 2.0;
	uv *= 23.0+ sin(time);     //  set zoom size //23.0 + sin(time)
	if (REPEAT_SIGN)
	  uv = -14.0 + mod(1.8*(uv-1.0),ch_space*vec2(16.,6.5));     //  set zoom size //-14.0 + mod(1.8*(uv-1.0),ch_space*vec2(16.,6.5));

	ch_pos = ch_start + vec2(sin(time), 3.0);  // set start position

  _ _ G A M E _ O V E R nl1
	S C O R E _ create_number(score, 2);

	vec3 color = mix(ch_color*(1.4), bg_color, 1.0- (0.03 / d));  // shading

	color -= 1.3; //+.0*(cos(uv.x+time)+cos(uv.y+time));

	float c = 1.0;

	gl_FragColor = vec4(color, 1.) + vec4(vec3(c*c*c*c*c*c), 1.) + vec4(128./250., 39./250., 63./250., 1.0);

  vec3 img_color = gl_FragColor.rgb;
  vec3 filter_color = vec3(0.8, 0.8, 0.8);

  img_color -= 0.8;
  gl_FragColor = vec4(img_color, 1.);
}
