import { Dialog, Transition } from '@headlessui/react';
import React, { Fragment, useEffect } from 'react';
import Icon from '@/components/ui/Icon';

const MemberInfoModal = ({
  activeModal,
  onClose,
  noFade,
  disableBackdrop,
  className = 'max-w-xl',
  children,
  footerContent,
  centered,
  scrollContent,
  themeClass = 'bg-slate-900 dark:bg-slate-800 dark:border-b dark:border-slate-700',
  title = 'Basic Modal',
  uncontrol,
  label = 'Basic Modal',
  labelClass,
  ref,
  showModal,
  setShowModal,
  isGoBackClicked,
}) => {
  // history.scrollRestoration = 'auto';

  const closeModal = () => {
    setShowModal(false);
  };

  const openModal = () => {
    setShowModal(!showModal);
  };
  const returnNull = () => {
    return null;
  };

  // 모달 닫은 뒤에도 위치 고정
  // 모달 창에서 백스페이스 누를 시 모달창만 꺼지도록
  if (showModal) {
    // const [isGoBackClicked, setIsGoBackClicked] = useState(false);
    const scrollY = window.scrollY;

    // const goBack = () => {
    //   console.log('goBack');
    //   isGoBackClicked = true;
    //   closeModal();
    // };

    useEffect(() => {
      // const scrollPosition = window.scrollY;
      console.log('savePos:', scrollY);
      localStorage.setItem('scrollY', scrollY);

      document.body.style.cssText = `
      position: fixed;
      top: -${scrollY}px;
      overflow-y: scroll;
      width: 100%;`;

      // history.pushState({ page: 'modal' }, document.title, location.pathname + '#modal');
      // window.addEventListener('popstate', goBack);
      // console.log('popstate');

      return () => {
        const savedScrollY = localStorage.getItem('scrollY');
        // window.removeEventListener('popstate', goBack);
        // console.log('isGoBackClicked:', isGoBackClicked);
        // if (!isGoBackClicked) {
        //   history.back();
        // }

        if (savedScrollY) {
          console.log('savedScrollY:', savedScrollY);
          window.scrollTo(0, savedScrollY);
          localStorage.removeItem('scrollY');
        }
        document.body.style.cssText = '';
      };
    }, []);
  }

  // useEffect(() => {
  //   history.pushState({ page: 'modal' }, document.title);
  //   // document.addEventListener('popstate', goBack);

  //   document.addEventListener('keydown', function (e) {
  //     console.log(e);

  //     if (e.code == 'Backspace') {
  //       console.log('back');
  //       goBack();
  //     }
  //   });

  //   return () => {
  //     document.addEventListener('keydown', function (e) {
  //       console.log(e);

  //       if (e.keycode == 8) {
  //         console.log('back');
  //         goBack();
  //       }
  //     });
  //     if (!isGoBackClicked) {
  //       history.back();
  //     }
  //   };
  // }, []);

  return (
    <>
      {uncontrol ? (
        <>
          {/* <button type="button" onClick={openModal} className={`btn ${labelClass}`}>
            {label}
          </button> */}
          <Transition appear show={showModal} as={Fragment}>
            <Dialog as='div' className='relative z-[99999]' onClose={!disableBackdrop ? closeModal : returnNull}>
              {!disableBackdrop && (
                <Transition.Child
                  as={Fragment}
                  enter={noFade ? '' : 'duration-300 ease-out'}
                  enterFrom={noFade ? '' : 'opacity-0'}
                  enterTo={noFade ? '' : 'opacity-100'}
                  leave={noFade ? '' : 'duration-200 ease-in'}
                  leaveFrom={noFade ? '' : 'opacity-100'}
                  leaveTo={noFade ? '' : 'opacity-0'}
                >
                  <div className='fixed inset-0 bg-slate-900/50 backdrop-filter backdrop-blur-sm' />
                </Transition.Child>
              )}

              <div className='fixed inset-0 overflow-y-auto'>
                <div
                  className={`flex min-h-full justify-center text-center p-6 ${
                    centered ? 'items-center' : 'items-start '
                  }`}
                >
                  <Transition.Child
                    as={Fragment}
                    enter={noFade ? '' : 'duration-300  ease-out'}
                    enterFrom={noFade ? '' : 'opacity-0 scale-95'}
                    enterTo={noFade ? '' : 'opacity-100 scale-100'}
                    leave={noFade ? '' : 'duration-200 ease-in'}
                    leaveFrom={noFade ? '' : 'opacity-100 scale-100'}
                    leaveTo={noFade ? '' : 'opacity-0 scale-95'}
                  >
                    <Dialog.Panel
                      className={`w-full transform overflow-hidden rounded-md
                 bg-white dark:bg-slate-800 text-left align-middle shadow-xl transition-alll ${className}`}
                    >
                      <div
                        className={`relative overflow-hidden py-4 px-5 text-white flex justify-between  ${themeClass}`}
                      >
                        <h2 className='capitalize leading-6 tracking-wider font-medium text-base text-white'>
                          {title}
                        </h2>
                        <button onClick={closeModal} className='text-[22px]'>
                          <Icon icon='heroicons-outline:x' />
                        </button>
                      </div>
                      <div className={`px-6 py-8 ${scrollContent ? 'overflow-y-auto max-h-[400px]' : ''}`}>
                        {children}
                      </div>
                      {footerContent && (
                        <div className='px-4 py-3 flex justify-end space-x-3 border-t border-slate-100 dark:border-slate-700'>
                          {footerContent}
                        </div>
                      )}
                    </Dialog.Panel>
                  </Transition.Child>
                </div>
              </div>
            </Dialog>
          </Transition>
        </>
      ) : (
        <Transition appear show={activeModal} as={Fragment}>
          <Dialog as='div' className='relative z-[99999]' onClose={onClose}>
            <Transition.Child
              as={Fragment}
              enter={noFade ? '' : 'duration-300 ease-out'}
              enterFrom={noFade ? '' : 'opacity-0'}
              enterTo={noFade ? '' : 'opacity-100'}
              leave={noFade ? '' : 'duration-200 ease-in'}
              leaveFrom={noFade ? '' : 'opacity-100'}
              leaveTo={noFade ? '' : 'opacity-0'}
            >
              {!disableBackdrop && <div className='fixed inset-0 bg-slate-900/50 backdrop-filter backdrop-blur-sm' />}
            </Transition.Child>

            <div className='fixed inset-0 overflow-y-auto'>
              <div
                className={`flex min-h-full justify-center text-center p-6 ${
                  centered ? 'items-center' : 'items-start '
                }`}
              >
                <Transition.Child
                  as={Fragment}
                  enter={noFade ? '' : 'duration-300  ease-out'}
                  enterFrom={noFade ? '' : 'opacity-0 scale-95'}
                  enterTo={noFade ? '' : 'opacity-100 scale-100'}
                  leave={noFade ? '' : 'duration-200 ease-in'}
                  leaveFrom={noFade ? '' : 'opacity-100 scale-100'}
                  leaveTo={noFade ? '' : 'opacity-0 scale-95'}
                >
                  <Dialog.Panel
                    className={`w-full transform overflow-hidden rounded-md
                 bg-white dark:bg-slate-800 text-left align-middle shadow-xl transition-alll ${className}`}
                  >
                    <div
                      className={`relative overflow-hidden py-4 px-5 text-white flex justify-between  ${themeClass}`}
                    >
                      <h2 className='capitalize leading-6 tracking-wider font-medium text-base text-white'>{title}</h2>
                      <button onClick={onClose} className='text-[22px]'>
                        <Icon icon='heroicons-outline:x' />
                      </button>
                    </div>
                    <div className={`px-6 py-8 ${scrollContent ? 'overflow-y-auto max-h-[400px]' : ''}`}>
                      {children}
                    </div>
                    {footerContent && (
                      <div className='px-4 py-3 flex justify-end space-x-3 border-t border-slate-100 dark:border-slate-700'>
                        {footerContent}
                      </div>
                    )}
                  </Dialog.Panel>
                </Transition.Child>
              </div>
            </div>
          </Dialog>
        </Transition>
      )}
    </>
  );
};

export default MemberInfoModal;
