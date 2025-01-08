function [out] = GPR_ARTMO_to_pyee(model_mat_f,suffix,dir_out)

prec_digits =15;

[mat_dir,mat_f,~] = fileparts(model_mat_f);
if ~exist('suffix','var');suffix ='';end
if ~exist('dir_out','var')
    dir_out = fullfile(mat_dir,mat_f);
    if ~exist(dir_out,'dir');mkdir(mat_dir,mat_f);end
end

model   = load(model_mat_f);
L_mat   = model.modelo.model.model.L;
Linv_mat   = inv(L_mat);

Xtr     = model.modelo.model.model.Xtrain;
alpha   = model.modelo.model.model.alpha;
mx      = model.modelo.model.normvalues.mx;
sx      = model.modelo.model.normvalues.sx;
mean    = model.modelo.model.mean;
hyp_vec = model.modelo.model.model.loghyper;
Bands   = numel(hyp_vec)-2; 
vi      = model.modelo.name;

invell2_v  = 1./exp(2*hyp_vec(1:Bands));
D_ell2  = diag(invell2_v);
sf2     = exp(2*hyp_vec(Bands+1));
s2      = exp(2*hyp_vec(Bands+2));
XTDX    = sum(Xtr*D_ell2.*Xtr,2);
s2unc   = s2 + sf2;

L_mat_f   = fullfile(dir_out,[mat_f '_L.txt']);
Linv_mat_f   = fullfile(dir_out,[mat_f '_Linv.txt']);
Xtr_f     = fullfile(dir_out,[mat_f '_Xtr.txt']);
alpha_f   = fullfile(dir_out,[mat_f '_alpha.txt']);
mx_f      = fullfile(dir_out,[mat_f '_mx.txt']);
sx_f      = fullfile(dir_out,[mat_f '_sx.txt']);
mean_f    = fullfile(dir_out,[mat_f '_mean.txt']);
inv_l2_f  = fullfile(dir_out,[mat_f '_inv_ell2.txt']);
sf2_f     = fullfile(dir_out,[mat_f '_sf2.txt']);
s2_f      = fullfile(dir_out,[mat_f '_s2.txt']);
XTDX_f    = fullfile(dir_out,[mat_f '_XTDX.txt']);
s2unc_f      = fullfile(dir_out,[mat_f '_s2unc.txt']);

Xtr_1 = reshape(Xtr,size(Xtr,1),1,size(Xtr,2));

% dlmwrite(L_mat_f,  L_mat ,   'delimiter', ',', 'precision', prec_digits);
% dlmwrite(Xtr_f,    Xtr,      'delimiter', ',', 'precision', prec_digits);
% dlmwrite(alpha_f,  alpha,    'delimiter', ',', 'precision', prec_digits);
% dlmwrite(mx_f,     mx,       'delimiter', ',', 'precision', prec_digits);
% dlmwrite(sx_f,     sx,       'delimiter', ',', 'precision', prec_digits);
% dlmwrite(mean_f,   mean,     'delimiter', ',', 'precision', prec_digits);
% dlmwrite(inv_l2_f, invell2_v,'delimiter', ',', 'precision', prec_digits);
% dlmwrite(sf2_f,    sf2,      'delimiter', ',', 'precision', prec_digits);
% dlmwrite(s2_f,     s2,       'delimiter', ',', 'precision', prec_digits);
% dlmwrite(XTDX_f,   XTDX,     'delimiter', ',', 'precision', prec_digits);
% dlmwrite(s2unc_f,   s2unc,     'delimiter', ',', 'precision', prec_digits);
% dlmwrite(Linv_mat_f,  Linv_mat ,   'delimiter', ',', 'precision', prec_digits);
% out = 1;

Xtr_str     = matrix2str(Xtr,        ['X_train' suffix ' = ee.Array([']            ,'['  ,''  ,','    , ']'   ,',' ,prec_digits ,']);' );
alpha_str   = matrix2str(alpha',     ['alpha_coefficients' suffix ' = ee.Image([['] ,''   ,''  ,','    , ''    ,''  ,prec_digits ,']]);' );
mx_str      = matrix2str(mx,         ['mx' suffix '       =  ee.Image([[']          ,''   ,''  ,','    , ''    ,''  ,prec_digits ,']]);' );
sx_str      = matrix2str(sx,         ['sx' suffix '       =  ee.Image([[']          ,''   ,''  ,','    , ''    ,''  ,prec_digits ,']]);' );
mean_str    = matrix2str(mean,       ['mean_model' suffix ' = ']                    ,''   ,''  ,','    , ''    ,''  ,prec_digits ,';' );
inv_l2_str  = matrix2str(invell2_v', ['hyp_ell' suffix '  = ee.Image([']            ,''   ,''  ,','    , ''    ,''  ,prec_digits ,']);' );
sf2_str     = matrix2str(sf2,        ['hyp_sig' suffix '  =']                       ,''   ,''  ,','    , ''    ,''  ,prec_digits ,';'   );
s2_str      = matrix2str(s2,         ['hyp_sign' suffix ' = ee.Array([']            ,''   ,''  ,''     , ''    ,''  ,prec_digits ,']);'   );
XTDX_str    = matrix2str(XTDX,       ['XDX_pre_calc' suffix ' =  ee.Image([']       ,'['   ,'[' , '],'  , ']'  ,','  ,prec_digits ,']);' );
Linv_str    = matrix2str(Linv_mat,   ['Linv_pre_calc' suffix ' =  ee.Array([']      ,'['   ,'' , ','  , ']'  ,','  ,prec_digits ,']);' );
s2unc_str      = matrix2str(s2unc,   ['hyp_sig_unc' suffix ' = ']                   ,''   ,''  ,','    , ''    ,''  ,prec_digits ,';'   );     

overall_model_py_f = fullfile(dir_out,'ARTMO_model_pyee.py');

Nmax_col = numel(Xtr_str);
fid = fopen(overall_model_py_f,'wt');
if fid
    fprintf(fid,'import ee;\n');
    fprintf(fid,'\n');
    split_str4file(fid,Xtr_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,alpha_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,mx_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,sx_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,mean_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,inv_l2_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,s2_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,sf2_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,s2unc_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,XTDX_str,Nmax_col);fprintf(fid,'\n');
    split_str4file(fid,Linv_str,Nmax_col);fprintf(fid,'\n');
    fprintf(fid,"veg_index = '%s' ;\n",vi);
    [pathstr,modelFileName,ext] = fileparts(model_mat_f);
    fprintf(fid,"model = '%s' ;\n",modelFileName);
    fprintf(fid,'XTrain_dim_GREEN = X_train_GREEN.length().toList().get(0).getInfo();\n');
    fprintf(fid,['scaleFactor' suffix '= 10000;\n']);
    fprintf(fid,'\n');
    
end

fclose(fid);

out = 1;

disp('ARTMO model successfully exported (Python with ee API)');





function split_str4file(fid,str_info,Nmax_col)
    Ncol = numel(str_info);
    col_vec = 1:Nmax_col:Ncol;
    if col_vec(end)<Ncol
        col_vec=[col_vec Ncol+1];
    end
    
    for i_str=2:numel(col_vec)-1
        ind = col_vec(i_str);
        if ~strcmp(str_info(ind),',')
            cnd =true;
            while(cnd)
                ind=ind+1;
                if strcmp(str_info(ind),',')
                    cnd=false;
                end
            end
        end
        col_vec(i_str)=ind;
    end
       
    for i_str=1:numel(col_vec)-1
        fprintf(fid,'%s\n',str_info(col_vec(i_str):col_vec(i_str+1)-1));
    end



function out_str = matrix2str(matrix,header_str,st_line,delim_st,delim_end, end_line,delim_line,precision,tail_str)

% matrix   : Matrix to be prepared for GEE
% header_str : header string
% delim_st   : front element delimiter
% delim_end  : back element delimiter
% end_line   : end-line delimiter
% precision  : precision for number to string conversion
% tail_str   : string final tail

[nl, nc] = size(matrix);
str_vec_l = header_str;
for i_l = 1:nl
    str_vec_c = st_line;
    for i_c = 1:nc
        if i_c < nc; delim_st_ = delim_st; else delim_st_ = ''; end

        if i_c < nc; delim_end_ = delim_end; else delim_end_ = ''; end
        str_vec_c = [str_vec_c delim_st_ num2str(matrix(i_l, i_c), precision) delim_end_];
    end
    if i_l < nl
        str_vec_c = [str_vec_c end_line delim_line];
    else
        str_vec_c = [str_vec_c end_line];
    end
    str_vec_l = [str_vec_l str_vec_c];
end

out_str = [str_vec_l tail_str];