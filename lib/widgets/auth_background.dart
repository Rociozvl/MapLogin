import "package:flutter/material.dart";

class AuthBackground extends StatelessWidget {
  
  final Widget child;

  const AuthBackground({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [

           
             _PurpleBox(),
            _HeaderIcon(),

           child,

          ],
        ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only( top: 30 ),
        child: const Icon( Icons.person_pin, color: Colors.white, size: 100 ),
      ),
    );
  }
}



 class _PurpleBox extends StatelessWidget {

   @override
   Widget build(BuildContext context) {

     //final size = MediaQuery.of(context).size;

     return Container(
       width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 38, 3, 61),
        //  decoration:  const BoxDecoration(
        //   gradient: LinearGradient(
        //   colors: [Color.fromARGB(255, 97, 26, 133), Color.fromARGB(255, 35, 7, 41)], // Cambia estos colores según necesites
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        // boxShadow: [
        //    BoxShadow(
        //     color: const Color.fromARGB(255, 173, 70, 70).withOpacity(0.3),
        //     blurRadius: 50,
        //     spreadRadius: 2,
        //     offset: const Offset(0, 5),
        //   ),
        // ]
        // ),
       
         child:  Stack(
          children: [
              ClipPath(
            clipper: HalfCircleClipper(),
            child: Container(
              height: 370,
              
              
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 106, 23, 117), Color.fromARGB(255, 38, 3, 61),], // Cambia estos colores según necesites
                  begin: FractionalOffset(0.1, 0.5),
                  end: FractionalOffset(0.1, 0.1),
                ),
                
              )
            ),

           )
           
  
          ],
         )
         );
         
         }
  
}
 class HalfCircleClipper extends CustomClipper<Path> {
   @override
   Path getClip(Size size) {
     final path = Path();
     path.moveTo(0, size.height / 2);
     path.arcToPoint(
       Offset(size.width, size.height / 2),
       radius: Radius.circular(size.width),
       clockwise: false,
     );
     path.lineTo(size.width, 0);
     path.lineTo(0, 0);
     path.close();
     return path;
   }
   
   
    
   

   @override
   bool shouldReclip( HalfCircleClipper  oldClipper) {
     return false;
   }
 }