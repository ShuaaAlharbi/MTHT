function a = VectorVectorAngle3D(Ax,Ay,Az,Bx,By,Bz)
%a = atan2(norm(cross([Ax Ay Az],[Bx By Bz])), dot([Ax Ay Az],[Bx By Bz]));
fCrossX = Ay .* Bz - Az .* By;
fCrossY = Az .* Bx - Ax .* Bz;
fCrossZ = Ax .* By - Ay .* Bx;
fCross = sqrt(fCrossX .* fCrossX + fCrossY .* fCrossY + fCrossZ .* fCrossZ);
%fDot = Ax .* Bx + Ay .* By + Az + Bz;
fDot = Ax .* Bx + Ay .* By + Az .* Bz;
a = atan2(fCross,fDot);
end