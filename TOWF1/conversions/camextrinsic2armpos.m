function TTxend=camextrinsic2armpos(TTcam,TTcamreference,TTarm)

TTxend=TTarm*(TTcam^-1*TTcamreference);

end