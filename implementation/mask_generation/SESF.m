function [Dy_pred, Dx_pred] = SESF(Dy_true, Dy_pred, Dx_true, Dx_pred, lr_translation)

    Dy_pred = lr_translation .* Dy_true + ((1 - lr_translation) * Dy_pred); 
    Dx_pred = lr_translation .* Dx_true + ((1 - lr_translation) * Dx_pred); 
    
end