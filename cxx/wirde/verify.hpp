#ifndef _valid_verify_hpp_
#define _valid_verify_hpp_
// 2017-04-19 (cc) <paul4hough@gmail.com>

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <ctime>
#include <cstring>

#if !defined VALID_VALIDATOR
#define VALID_VALIDATOR _validator
#endif

#define VALID_VERIFY_TRUE( _vobj_, _truth_ )		\
{							\
  bool           pass = false;				\
  valid::timer   timer;					\
  bool           ecaught = false;			\
  std::exception ethrown = valid::unkexcption();	\
  timer.start();					\
  try {							\
    pass = (_truth_);					\
  }							\
  catch( std::exception & e ) {				\
    ecaught = true;					\
    ethrown = e;					\
    pass = false;					\
  }							\
  catch( ... ) {					\
    ecaught = true;					\
    pass = false;					\
  }							\
  timer.stop();						\
							\
  _vobj_.check( pass,					\
		ecaught,				\
		ethrown,				\
		timer,					\
		#_truth_,				\
		__FILE__,				\
		__LINE__ );				\
}

#define VALID_VERIFY_THROWS( _vobj_, _expr_ )	\
{						\
  bool           pass = false;			\
  valid::timer   timer;				\
  bool           ecaught = false;		\
  std::exception ethrown(unkexcption());	\
  timer.start();				\
  try {						\
    (_expr_);					\
  }						\
  catch( std::exception & e ) {			\
    ecaught = true;				\
    ethrown = e;				\
    pass = true;				\
  }						\
  catch( ... ) {				\
    ecaught = true;				\
    pass = true;				\
  }						\
  timer.stop();					\
						\
  valid::verify::check( pass,			\
			timer,			\
			#_expr_,		\
			ecaught,		\
			ethrown,		\
			__FILE__,		\
			__LINE__ );		\
}

#define VALID_VERIFY_FAIL( _vobj_, _rsn_ )	\
  _vobj_.check( false,				\
		false,				\
		valid::unkexcption(),		\
		valid::timer(),			\
		_rsn_,				\
		__FILE__,			\
		__LINE__ )

#define VVDESC( _thing_ ) \
  valid::verify VALID_VALIDATOR( _thing_);

#define VVWHEN( _when_ )  \
  VALID_VALIDATOR.when( #_when_ ); _when_;

#define VVTRUE( _truth_ )    VALID_VERIFY_TRUE( VALID_VALIDATOR, _truth_ )
#define VVFAIL( _rsn_ )      VALID_VERIFY_FAIL( VALID_VALIDATOR, _rsn_ )
#define VVTHROWS( _throws_ ) VALID_VERIFY_THROWS( VALID_VALIDATOR, _truth_ )
#define VVFILE( _tfn_ )  \
  VALID_VALIDATOR.file( _tfn_, __FILE__, __LINE__)
#define VVEXPFILE( _tfn_, _efn_ )  \
  VALID_VALIDATOR.file( _tfn_, _efn_, __FILE__, __LINE__)

namespace valid {

class unkexcption : public std::exception {
public:
  virtual const char* what() const throw() { return "unknown"; };
};

class timer
{
public:
  timer( void ) { start(); };
  virtual ~timer( void ) {};

  void start( void ) {
    cbeg = std::clock();
    cend = 0;
  };
  void stop( void ) {
    cend = std::clock();
  };
  clock_t beg( void ) const { return cbeg; };
  clock_t end( void ) const { return cend; };
  clock_t dur( void ) const { return cend - cbeg; };

protected:
  clock_t cbeg;
  clock_t cend;
};

class verify
{

public:

  struct test_result {
    std::string    when;
    bool           pass;
    bool           ecaught;
    std::exception ethrown;
    timer          dur;
    std::string    desc;
    const char *   file;
    int            line;

    test_result( const char *     awhen,
		 bool             apass,
		 bool             aecaught,
		 const std::exception & aethrown,
		 timer            adur,
		 const char *     adesc,
		 const char *     afile,
		 int              aline ) :
      when(awhen),
      pass(apass),
      ecaught(aecaught),
      ethrown(aethrown),
      dur(adur),
      desc(adesc),
      file(afile),
      line(aline) {};
  };

  typedef std::vector<test_result> result_list;

  verify( const char * name = "" )
    : m_name(name), m_when(""), m_passing(true) {};

  virtual ~verify( void ) {};

  inline bool passing( void ) const { return m_passing; };
  inline bool is_valid(void) const;

  inline void check( bool           pass,
		     bool           ecaught,
		     const std::exception & ethrown,
		     const timer &          rtime,
		     const char *   desc,
		     const char *   file,
		     int            line );


  inline bool file( const char *    testFileName,
		    const char *    expFileName,
		    const char *    srcFn,
		    long	    srcLine );

  inline bool file( const char *    testFileName,
		    const char *    srcFn,
		    long	    srcLine );

  const result_list & results(void) const { return m_rlist; };
  result_list &       results(void) { return m_rlist; };

  inline const char *  name( void ) const { return m_name; };
  inline const char *  when( void ) const { return m_when; };
  inline void          when( const char * w ) { m_when = w; }

protected:
  const char * m_name;
  const char * m_when;
  bool         m_passing;
  result_list  m_rlist;
private:

  // verify( const verify & from );
  // verify & operator =( const verify & from );

};

inline
std::ostream &
operator << ( std::ostream & dest, const verify::test_result & src ) {
  if( ! src.pass ) {
    dest << "ERR:" << src.file << ':' << src.line << ' ';
  }
  dest << src.desc;
  if( src.dur.dur() ) {
    dest << " (" << src.dur.dur() << ")";
  }

  if( src.ecaught )
    dest << " excpt " << src.ethrown.what();

  return dest;
}

inline
std::ostream &
operator << ( std::ostream & dest, const verify::result_list & src ) {

  std::string twhen;

  for( verify::result_list::const_iterator them = src.begin();
       them != src.end();
       ++ them ) {
    if( (*them).when != twhen ) {
      dest << "  when " << (*them).when << std::endl;
      twhen = (*them).when;
    }
    dest << "    " << *them << std::endl;
  }
  return dest;
}

inline
std::ostream &
operator << ( std::ostream & dest, const verify & src ) {
  dest << "Validation "
       << (src.passing() ? "pass" : "FAIL")
       << " for " << src.name() << std::endl;
  dest << src.results() << std::endl;
  return( dest );
}

inline
bool
verify::is_valid(void) const {
  if( ! m_passing ) {
    std::cout << "ERROR:" << m_name << " one or more failures!" << std::endl;
    std::cout << m_rlist << std::endl;
  } else {
    std::cout << m_name  << ' '
	      << m_rlist.size()
	      << " validations passed :)"
	      << std::endl;
  }
  return m_passing;
}

inline
void
verify::check(
  bool			 pass,
  bool			 ecaught,
  const std::exception & ethrown,
  const timer &          rtime,
  const char *		 desc,
  const char *		 file,
  int			 line
) {

  test_result  res( m_when,
		    pass,
		    ecaught,
		    ethrown,
		    rtime,
		    desc,
		    file,
		    line );
  if( ! pass ) {
    std::cout << res << std::endl;
  }
  m_passing &= pass;
  m_rlist.push_back(res);
}



inline
bool
verify::file(
  const char *	testFileName,
  const char *	expFileName,
  const char *	srcFn,
  long		srcLine
  )
{
  size_t  byte = 0;

  std::ifstream testf( testFileName );
  std::ifstream expf( expFileName );

  if( testf.good() && expf.good() ) {

    char testBuf[4096];
    char expBuf[4096];

    for(;;) {
      testf.read( testBuf, sizeof( testBuf ) );
      expf.read( expBuf, sizeof( expBuf ) );

      if( testf.gcount() != expf.gcount() ) {
	check( false, false, valid::unkexcption(), valid::timer(),
	       "read count mismatch", srcFn, srcLine );
	return( false );
      }
      if( testf.good() && expf.good() && testf.gcount() > 0 ) {

	if( memcmp( testBuf, expBuf, testf.gcount() ) != 0 ) {
	  for( std::streamsize bufByte = 0;
	       bufByte < testf.gcount();
	       bufByte++ ) {
	    if( testBuf[ bufByte ] != expBuf[ bufByte ] ) {
	      char reason[128];
	      snprintf( reason, sizeof(reason),
			"Data mismatch at byte %ld",
			byte+bufByte );
	      check( false, false, valid::unkexcption(), valid::timer(),
		     reason, srcFn, srcLine );
	      return( false );
	    }
	    // should not reach
	    check( false, false, valid::unkexcption(), valid::timer(),
		   "memcmp lies :)", srcFn, srcLine );
	    return( false );
	  }
	}
      } else {
	if( testf.eof() && expf.eof() ) {
	  return( true );

	} else {
	  check( false, false, valid::unkexcption(), valid::timer(),
		 "read mismatch", srcFn, srcLine );
	  return( false );
	}
      }
    }
  }
  check( false, false, valid::unkexcption(), valid::timer(),
	 "open error", srcFn, srcLine );
  return( false );
}

inline
bool
verify::file(
  const char *	testFileName,
  const char *	srcFn,
  long		srcLine
  )
{
  char * expFileName = new char [ strlen( testFileName ) + 5 ];
  strcpy( expFileName, testFileName );
  strcat( expFileName, ".exp" );

  bool ret = file( testFileName, expFileName, srcFn, srcLine );
  delete expFileName;
  return( ret );
}


}; // namespace valid


#endif /* ! def _verify_hpp_ */
